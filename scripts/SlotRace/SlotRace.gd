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
	connect_signals()

# Connect signals
func connect_signals():
	curves.connect("right_curve", self, "_on_right_curve")
	curves.connect("left_curve", self, "_on_left_curve")
	animation_player1.connect("animation_finished", self, "_on_animation_finished", ["Player1"])
	animation_player2.connect("animation_finished", self, "_on_animation_finished", ["Player2"])

# Enable the player based on the animation
func _on_animation_finished(animation, player):
	if animation == "DerailRight" || animation == "DerailLeft":
		race_world.run_car(player)

# Handle car in curve events
func _on_right_curve(player):
	race_world.car_in_curve(player, "Right")

func _on_left_curve(player):
	race_world.car_in_curve(player, "Left")

# Called every frame
func _process(_delta: float):
	emit_signal_player1 = btn_player1.pressed
	emit_signal_player2 = btn_player2.pressed

	update_car_acceleration("Player1", emit_signal_player1)
	update_car_acceleration("Player2", emit_signal_player2)

func update_car_acceleration(player, emit_signal):
	if emit_signal:
		race_world.accelerate(player)
	else:
		race_world.stop_accelerate(player)
