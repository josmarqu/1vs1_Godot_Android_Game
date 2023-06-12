extends KinematicBody2D

var speed = 0
var direction = Vector2.ZERO

func _ready():
	randomize()
	direction.x = [-1,1][randi() % 2]
	direction.y = [-0.8,0.8][randi() % 2]

func _physics_process(delta):
	var collision_object = move_and_collide(direction * speed * delta)
	if collision_object:
		direction = direction.bounce(collision_object.normal)
		$CollisionSound.play()

func stop_ball():
	speed = 0
	

func restart_ball():
	speed = 700
	direction.x = [-1,1][randi() % 2]
	direction.y = [-0.8,0.8][randi() % 2]


