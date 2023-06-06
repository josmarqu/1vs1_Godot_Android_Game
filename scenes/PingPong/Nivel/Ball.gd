extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 600

func _ready():
	randomize()
	velocity.x = [-1,1][randi() % 2]
	velocity.y = [-0.8,0.8][randi() % 2]
	
func _physics_process(delta):
	var collision_object = move_and_collide(velocity * speed * delta)
	if collision_object:
		velocity = velocity.bounce(collision_object.normal)

func stop_ball():
	speed = 0
	
func restart_ball():
	speed = 600
	velocity.x = [-1,1][randi() % 2]
	velocity.x = [-0.8,0.8][randi() % 2]
