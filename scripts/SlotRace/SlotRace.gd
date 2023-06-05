extends Node

onready var btn_player1 = get_node("UI/Components/Player1MarginArea/Player1ControlPanel/Player1Button")
onready var btn_player2 = get_node("UI/Components/Player2MarginArea/Player2ControlPanel/Player2Button")
onready var race_world = get_node("RaceWorld")
onready var curves = get_node("RaceWorld/Curves")
onready var animation_player1 = get_node("RaceWorld/Player1Path2D/Player1PathFollow2D/Player1Area2D/BlueCar/AnimationPlayer1")
onready var animation_player2 = get_node("RaceWorld/Player2Path2D/Player2PathFollow2D/Player2Area2D/GreenCar/AnimationPlayer2")

var emit_signal_player1 = false
var emit_signal_player2 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect signals
	curves.connect("car_derail_right", self, "play_animation", ["Right"])
	curves.connect("car_derail_left", self, "play_animation", ["Left"])
	animation_player1.connect("animation_finished", self, "stop_animation", ["Player1"])
	animation_player2.connect("animation_finished", self, "stop_animation", ["Player2"])

# Enable the player based on the animation
func stop_animation(animation, player):
	if animation == "DerailRight" || animation == "DerailLeft":
		if player == "Player1":
			race_world.run_car("Player1")
		elif player == "Player2":
			race_world.run_car("Player2")

func play_animation(player, pos):
	if player == "Player1Area2D":
		if pos == "Right":
			race_world.play_animation("Player1", "Right")
		if pos == "Left":
			race_world.play_animation("Player1", "Left")
			
	elif player == "Player2Area2D":
		if pos == "Right":
			race_world.play_animation("Player2", "Right")
		if pos == "Left":
			race_world.play_animation("Player2", "Left")
			
# Called every frame
func _process(delta: float):
	if btn_player1.pressed == true:
			emit_signal_player1 = true
	elif btn_player2.pressed == true:
			emit_signal_player2 = true
	else:
		emit_signal_player1 = false
		emit_signal_player2 = false
			
	update_car_acceleration("Player1", emit_signal_player1)
	update_car_acceleration("Player2", emit_signal_player2)

func update_car_acceleration(player, emit_signal):
	if emit_signal:
		race_world.accelerate(player)
	else:
		race_world.stop_accelerate(player)
