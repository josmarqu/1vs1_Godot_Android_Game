extends KinematicBody2D

var speed = 400

func _physics_process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 400
	elif Input.is_action_pressed("ui_right"):
		velocity.x += 400
	move_and_slide(velocity)
	
	



