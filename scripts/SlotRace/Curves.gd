extends Node

signal car_derail_right(car)
signal car_derail_left(car)

func _ready():
	pass

func _on_right_curve_body_entered(body):
	if body.is_in_group("Player1"):
		emit_signal("car_derail_right", body.name)
	if body.is_in_group("Player2"):
		emit_signal("car_derail_right", body.name)

func _on_left_curve_body_entered(body):
	if body.is_in_group("Player1"):
		emit_signal("car_derail_left", body.name)
	if body.is_in_group("Player2"):
		emit_signal("car_derail_left", body.name)
