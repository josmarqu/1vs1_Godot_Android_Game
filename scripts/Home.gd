extends Node

var global_sound = AudioServer.get_bus_index("Master")
var main_theme = AudioServer.get_bus_index("MainTheme")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/GameSelector.tscn")

func _on_MusicButton_pressed():
	AudioServer.set_bus_mute(main_theme, not AudioServer.is_bus_mute(main_theme))

func _on_SpeakerButton_pressed():
	AudioServer.set_bus_mute(global_sound, not AudioServer.is_bus_mute(global_sound))
	AudioServer.set_bus_mute(main_theme, not AudioServer.is_bus_mute(main_theme))
