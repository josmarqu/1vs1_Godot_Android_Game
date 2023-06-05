
extends Node

func _ready():
	var btn_start_game = get_node("StartButton")
	btn_start_game.connect("pressed", self, "_on_button_pressed", [btn_start_game])

func _on_button_pressed(button):
	match button.name:
		"StartButton":
			get_tree().change_scene("res://scenes/Minigames.tscn")
