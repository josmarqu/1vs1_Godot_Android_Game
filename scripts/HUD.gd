extends Control

const target_score = 7

var blue_score = 0
var red_score = 0

var game_finished = false

onready var table = $Table
onready var blue_score_label = $BlueScore
onready var red_score_label = $RedScore

func _unhandled_input(event):
	if event is InputEventScreenTouch and game_finished == true:
		if event.pressed:
			new_game()

func new_game():
	table._ready()
	game_finished = false
	blue_score = 0
	red_score = 0
	blue_score_label.text = "Blue : " + str(blue_score)
	red_score_label.text = "Red : " + str(red_score)

func _on_blue_scored():
	blue_score += 1
	blue_score_label.text = "Blue : " + str(blue_score)
	if blue_score == target_score and game_finished == false:
		game_finished = true

func _on_red_scored():
	red_score += 1
	red_score_label.text = "Red : " + str(red_score)
	if red_score == target_score and game_finished == false:
		game_finished = true
