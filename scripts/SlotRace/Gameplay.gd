extends Node

var btn_player1: Button
var btn_player2: Button
var car_player1: Node2D
var car_player2: Node2D


func _ready():
	# init buttons
	btn_player1 = get_node("UI/Components/Player1MarginArea/Player1ControlPanel/Player1Button")
	btn_player1.connect("pressed", self, "_on_button_pressed", [btn_player1])
	btn_player2 = get_node("UI/Components/Player2MarginArea/Player2ControlPanel/Player2Button")
	btn_player2.connect("pressed", self, "_on_button_pressed", [btn_player2])
	
	# init alpha2d elements
	car_player1 = get_node("RaceWorld/Player1Path2D/Player1PathFollow2D/Player1Area2D")
	car_player2 = get_node("RaceWorld/Player2Path2D/Player2PathFollow2D/Player2Area2D")


func _on_button_pressed(button: Button):
	# Accelerate each car depend of the button pressed
	var path_follow: PathFollow2D = null

	if button == btn_player1:
		path_follow = car_player1.get_parent()
	elif button == btn_player2:
		path_follow = car_player2.get_parent()
	if path_follow != null:
		path_follow.offset += 50
	else:
		print("PathFollow2D not found for button:", button.name)
