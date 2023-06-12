extends Node

onready var air_hockey_btn = get_node("Components/Buttons/Control/AirHockeyButton")
onready var ping_pong_btn = get_node("Components/Buttons/Control2/PingPongButton")
onready var slot_race_btn = get_node("Components/Buttons/Control3/SlotRaceButton")

# Called when the node enters the scene tree for the first time.
func _ready():
		pass

func _on_AirHockeyButton_pressed():
	ping_pong_btn.pressed = false
	slot_race_btn.pressed = false

func _on_PingPongButton_pressed():
	air_hockey_btn.pressed = false
	slot_race_btn.pressed = false

func _on_SlotRaceButton_pressed():
	air_hockey_btn.pressed = false
	ping_pong_btn.pressed = false

func _on_GoBackButton_pressed():
	get_tree().change_scene("res://scenes/Home.tscn")

func _on_PlayButton_pressed():
	if ping_pong_btn.pressed == true:
		get_tree().change_scene("res://scenes/PingPong/Level.tscn")
	elif slot_race_btn.pressed == true:
		get_tree().change_scene("res://scenes/SlotRace.tscn")
	elif air_hockey_btn.pressed == true:
		get_tree().change_scene("res://scenes/AirHockey.tscn")
