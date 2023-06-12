extends Control

signal p
var global_sound = AudioServer.get_bus_index("Master")
var main_theme = AudioServer.get_bus_index("MainTheme")
onready var music_btn = get_node("Components/Control2/MusicButton")
onready var speaker_btn = get_node("Components/Control3/SpeakerButton")

# Called when the node enters the scene tree for the first time.
func _ready():
	if AudioServer.is_bus_mute(global_sound):
		speaker_btn.pressed = true
	if AudioServer.is_bus_mute(main_theme):
		music_btn.pressed = true

func _on_PlayButton_pressed():
	get_tree().paused = false
	emit_signal("p")
	self.queue_free()
	pass

func _on_MusicButton_pressed():
	AudioServer.set_bus_mute(main_theme, not AudioServer.is_bus_mute(main_theme))

func _on_SpeakerButton_pressed():
	AudioServer.set_bus_mute(global_sound, not AudioServer.is_bus_mute(global_sound))

func _on_GoBackButton_pressed():
	get_tree().paused = false
	emit_signal("p")
	self.queue_free()
	get_tree().change_scene("res://scenes/GameSelector.tscn")
