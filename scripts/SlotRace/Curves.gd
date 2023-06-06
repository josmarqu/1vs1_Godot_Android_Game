extends Node

signal right_curve(player)
signal left_curve(player)

func _ready():
	pass

func _on_right_curve_body_entered(body):
	if body.is_in_group("Player1"):
		emit_signal("right_curve", "Player1")
	if body.is_in_group("Player2"):
		emit_signal("right_curve", "Player2")

func _on_left_curve_body_entered(body):
	if body.is_in_group("Player1"):
		emit_signal("left_curve", "Player1")
	if body.is_in_group("Player2"):
		emit_signal("left_curve", "Player2")
