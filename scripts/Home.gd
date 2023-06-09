extends Node

var global_sound = AudioServer.get_bus_index("Master")
var main_theme = AudioServer.get_bus_index("MainTheme")
onready var music_btn = get_node("Components/ButtonsContainer/VBoxContainer/HBoxContainer/Control/MusicButton")
onready var speaker_btn = get_node("Components/ButtonsContainer/VBoxContainer/HBoxContainer/Control2/SpeakerButton")

# Called when the node enters the scene tree for the first time.
func _ready():
	if AudioServer.is_bus_mute(global_sound):
		speaker_btn.pressed = true
	if AudioServer.is_bus_mute(main_theme):
		music_btn.pressed = true
	
func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/GameSelector.tscn")

func _on_MusicButton_pressed():
	AudioServer.set_bus_mute(main_theme, not AudioServer.is_bus_mute(main_theme))

func _on_SpeakerButton_pressed():
	AudioServer.set_bus_mute(global_sound, not AudioServer.is_bus_mute(global_sound))
