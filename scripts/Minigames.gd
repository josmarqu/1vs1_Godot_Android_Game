extends Node

func _ready():
	var hbox_container = get_node("HBoxContainer")
	var btn_race = hbox_container.get_node("Slot Race")
	btn_race.connect("pressed", self, "_on_button_pressed", [btn_race])

	var btn_ping_pong = hbox_container.get_node("Ping Pong")
	btn_ping_pong.connect("pressed", self, "_on_button_pressed", [btn_ping_pong])

	var btn_air_hockey = hbox_container.get_node("Air Hockey")
	btn_air_hockey.connect("pressed", self, "_on_button_pressed", [btn_air_hockey])

func _on_button_pressed(button):
	match button.name:
		"Slot Race":
			get_tree().change_scene("res://scenes/SlotRace.tscn")
	match button.name:
		"Ping Pong":
			get_tree().change_scene("res://scenes/PingPong.tscn")
	match button.name:
		"Air Hockey":
			get_tree().change_scene("res://scenes/AirHockey.tscn")
