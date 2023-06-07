extends Node2D

signal red_scored
signal blue_scored

var red_turning = false
var blue_turning = false
var red_attack = false
var blue_attack = false

var score_allowed = true

var auto_centering = true

var p1_pressing = false
var p2_pressing = false
var p1_index
var p2_index
var p1_target_position
var p2_target_position

var blue_score = 0
var red_score = 0

var vibration_supported = false

onready var blue = $Blue
onready var red = $Red
onready var blue_goal_particles = $BlueGoalParticles
onready var red_goal_particles = $RedGoalParticles

onready var puck = $Puck
onready var puck_sprite = $Puck/PuckSprite
onready var puck_explosion_particles = $PuckExplosionParticles
onready var puck_timer = $PuckTimer

onready var tween = $Tween

onready var spawn_sound = $SpawnSound
onready var score_sound = $ScoreSound

func _ready():
	spawn_sound.play()
	blue.position = Vector2(100, 300)
	red.position = Vector2(924, 300)
	puck.position = Vector2(512, 300)
	puck.linear_velocity = Vector2.ZERO
	puck.angular_velocity = 0
	tween.interpolate_property(puck_sprite, "modulate", \
			Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1, Tween.TRANS_CUBIC)
	tween.interpolate_property(puck_sprite, "scale", \
			Vector2(1.5, 1.5), Vector2(1, 1), 1, Tween.TRANS_CUBIC)
	tween.start()
	if OS.get_name() == "Android" || "iOS":
		vibration_supported = true

func _unhandled_input(event):
	if event is InputEventScreenDrag:
		if p1_pressing == true and event.index == p1_index:
			blue.move_and_slide((event.position - blue.global_position) * 40)
		if p2_pressing == true and event.index == p2_index:
			red.move_and_slide((event.position - red.global_position) * 40)
	if event is InputEventScreenTouch:
		if event.pressed:
			if event.position.y > 600:
				p1_index = event.index
				p1_pressing = true
			if event.position.y < 600:
				p2_index = event.index
				p2_pressing = true
		if event.pressed == false:
			if event.index == p1_index:
				p1_pressing = false
			if event.index == p2_index:
				p2_pressing = false

func _on_PuckVisibilityNotifier_screen_exited():
	center_puck()

func _on_BlueGoal_body_entered(body):
	if body.name == "Puck" and score_allowed:
		goal()
		blue_goal_particles.emitting = true
		emit_signal("red_scored")

func _on_RedGoal_body_entered(body):
	if body.name == "Puck" and score_allowed:
		goal()
		red_goal_particles.emitting = true
		emit_signal("blue_scored")

func goal():
	puck.hide()
	puck.set_deferred("mode", RigidBody2D.MODE_STATIC)
	puck_explosion_particles.position = puck.position
	puck_explosion_particles.direction = puck.linear_velocity
	puck_explosion_particles.emitting = true
	score_allowed = false
	auto_centering = false
	score_sound.play()
	if vibration_supported:
		Input.vibrate_handheld()
	puck_timer.start()

func _on_Tween_tween_step(_object, _key, elapsed, _value):
	if elapsed >= 0.5:
		puck.mode = RigidBody2D.MODE_RIGID

func _on_PuckTimer_timeout():
	center_puck()
	puck.show()
	score_allowed = true
	auto_centering = true

func center_puck():
	spawn_sound.play()
	tween.interpolate_property(puck_sprite, "modulate", \
				Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1, Tween.TRANS_CUBIC)
	tween.interpolate_property(puck_sprite, "scale", \
				Vector2(1.5, 1.5), Vector2(1, 1), 1, Tween.TRANS_CUBIC)
	tween.start()
	puck.position = Vector2(512, 300)
	puck.linear_velocity = Vector2.ZERO
	puck.angular_velocity = 0

func _on_AttackTimer_timeout():
	if auto_centering:
		if randf() > 0.5:
			red_attack = true
		if randf() > 0.5:
			blue_attack = true
