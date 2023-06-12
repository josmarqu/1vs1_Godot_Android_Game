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

onready var blue = $Blue
onready var red = $Red

onready var puck = $Puck
onready var puck_sprite = $Puck/PuckSprite
onready var puck_timer = $PuckTimer

onready var spawn_sound = $SpawnSound
onready var score_sound = $ScoreSound

func _ready():
	spawn_sound.play()
	blue.position = Vector2(75, 300)
	red.position = Vector2(945, 300)
	puck.position = Vector2(512, 300)
	puck.linear_velocity = Vector2.ZERO
	puck.angular_velocity = 0

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
		emit_signal("red_scored")

func _on_RedGoal_body_entered(body):
	if body.name == "Puck" and score_allowed:
		goal()
		emit_signal("blue_scored")

func goal():
	puck.hide()
	puck.set_deferred("mode", RigidBody2D.MODE_STATIC)
	score_allowed = false
	auto_centering = false
	score_sound.play()
	puck_timer.start()


func _on_PuckTimer_timeout():
	center_puck()
	puck.set_deferred("mode", RigidBody2D.MODE_RIGID)
	puck.show()
	score_allowed = true
	auto_centering = true

func center_puck():
	spawn_sound.play()
	puck.position = Vector2(512, 300)
	puck.linear_velocity = Vector2.ZERO
	puck.angular_velocity = 0
