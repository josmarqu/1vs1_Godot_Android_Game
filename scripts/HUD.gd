extends Control

const target_score = 7

var blue_score = 0
var red_score = 0

var game_finished = false

onready var table = $Table
onready var blue_score_label = $BlueScore
onready var red_score_label = $RedScore
onready var blue_wins_overlay = $BlueWinsOverlay
onready var red_wins_overlay = $RedWinsOverlay
onready var blue_scores = $TextCenter/BlueScores
onready var red_scores = $TextCenter/RedScores

onready var tween = $Tween
onready var scoring_animation = $TextCenter/ScoringAnimation

func _unhandled_input(event):
	if event is InputEventScreenTouch and game_finished == true:
		if event.pressed:
			new_game()

func new_game():
	blue_wins_overlay.visible = false
	red_wins_overlay.visible = false
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
		tween.interpolate_property(blue_wins_overlay, "modulate", \
				Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.5, Tween.TRANS_CUBIC)
		tween.start()
		blue_wins_overlay.visible = true
		game_finished = true
	else:
		blue_scores.visible = true
		scoring_animation.play("PlayerScore")

func _on_red_scored():
	red_score += 1
	red_score_label.text = "Red : " + str(red_score)
	if red_score == target_score and game_finished == false:
		tween.interpolate_property(red_wins_overlay, "modulate", \
				Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.5, Tween.TRANS_CUBIC)
		tween.start()
		red_wins_overlay.visible = true
		game_finished = true
	else:
		red_scores.visible = true
		scoring_animation.play("PlayerScore")

func _on_ScoringAnimation_animation_finished(anim_name):
	if anim_name == "PlayerScore":
		blue_scores.hide()
		red_scores.hide()
