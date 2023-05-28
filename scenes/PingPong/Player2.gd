extends KinematicBody2D

var speed = 400

func _physics_process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_w"):
		velocity.y -= 400
	elif Input.is_action_pressed("ui_s"):
		velocity.y += 400
	move_and_slide(velocity)
	
	



