extends Node

onready var btn_player1 = get_node("UI/Components/Player1/Player1MarginArea/Player1ControlPanel/Player1Button")
onready var btn_player2 = get_node("UI/Components/Player2/Player2MarginArea/Player2ControlPanel/Player2Button")
onready var race_world = get_node("RaceWorld")
onready var curves = get_node("RaceWorld/Curves")
onready var dash_board_player1 = get_node("UI/Components/Player1/Player1MarginArea/Player1ControlPanel/Player1DashBoard")
onready var dash_board_player2 = get_node("UI/Components/Player2/Player2MarginArea/Player2ControlPanel/Player2DashBoard")
onready var animation_player1 = get_node("RaceWorld/Player1Path2D/Player1PathFollow2D/Player1Area2D/BlueCar/AnimationPlayer1")
onready var animation_player2 = get_node("RaceWorld/Player2Path2D/Player2PathFollow2D/Player2Area2D/RedCar/AnimationPlayer2")
onready var animation_start_light = get_node("RaceWorld/StartLight/AnimationStartLight")
onready var start_light = get_node("RaceWorld/StartLight")
onready var audio_race_light_player = get_node("RaceWorld/AudioStreamRaceLight")
onready var audio_race_start_player = get_node("RaceWorld/AudioStreamRaceStart")
var race_light_audio = load("res://audio/race_light.mp3")
var race_start_audio = load("res://audio/race_start.mp3")

var emit_signal_player1: bool = false
var emit_signal_player2: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_race_light_player.stream = race_light_audio
	audio_race_light_player.stream.loop = false
	audio_race_start_player.stream = race_start_audio
	audio_race_start_player.stream.loop = false
	connect_signals()
	_start_light()
	

# Connect signals from others scripts and animations
func connect_signals():
	curves.connect("right_curve", self, "_on_right_curve")
	curves.connect("left_curve", self, "_on_left_curve")
	animation_player1.connect("animation_finished", self, "_on_animation_finished", ["Player1"])
	animation_player2.connect("animation_finished", self, "_on_animation_finished", ["Player2"])

# Enable the car after the animation is finished
func _on_animation_finished(animation: String, player: String):
	if animation == "DerailRight" || animation == "DerailLeft":
		race_world.run_car(player)

# Handle car in curve events
func _on_right_curve(player: String):
	race_world.car_in_curve(player, "Right")

func _on_left_curve(player: String):
	race_world.car_in_curve(player, "Left")

func _start_light():
	start_light.position = get_node("UI/Components").rect_size / 2
	animation_start_light.play("countdown")
	yield(animation_start_light, "animation_finished")
	start_light.visible = false
	race_world.run_car("Player1")
	race_world.run_car("Player2")
	
# Called every frame
func _process(_delta: float):
	# Change boolean value depending on the buttons state
	emit_signal_player1 = btn_player1.pressed
	emit_signal_player2 = btn_player2.pressed

	# Increase or reduce the car accelaration depending on the buttons state
	update_car_acceleration("Player1", emit_signal_player1)
	update_car_acceleration("Player2", emit_signal_player2)
	
	# Update the stats on the dashboards
	dash_board_player1.update_progress_bar(race_world.get_blue_car_speed())
	dash_board_player1.update_laps_indicator(race_world.get_blue_car_lap())
	
	dash_board_player2.update_progress_bar(race_world.get_red_car_speed())
	dash_board_player2.update_laps_indicator(race_world.get_red_car_lap())

func update_car_acceleration(player: String, emit_signal: bool):
	if emit_signal:
		race_world.accelerate(player)
	else:
		race_world.stop_accelerate(player)
