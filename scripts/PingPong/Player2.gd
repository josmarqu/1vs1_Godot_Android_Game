extends KinematicBody2D



func _physics_process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 600
	elif Input.is_action_pressed("ui_right"):
		velocity.x += 600
	move_and_slide(velocity)
	
	



