extends Node2D

const LAP_TARGET = 3

var blue_car_speed: float = 0
var green_car_speed: float = 0
onready var blue_car = get_node("Player1Path2D/Player1PathFollow2D")
onready var green_car = get_node("Player2Path2D/Player2PathFollow2D")
onready var blue_car_animation = get_node("Player1Path2D/Player1PathFollow2D/Player1Area2D/BlueCar/AnimationPlayer1")
onready var green_car_animation = get_node("Player2Path2D/Player2PathFollow2D/Player2Area2D/GreenCar/AnimationPlayer2")
var blue_car_laps: int = 0
var green_car_laps: int = 0
var blue_car_prev_offset: float = 0
var green_car_prev_offset: float = 0
var blue_car_running = true
var green_car_running = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func accelerate(player: String):
	var car_speed: int
	
	if player == "Player1" and blue_car_speed <= 0.005:
		car_speed = blue_car_speed
		blue_car_speed += 0.001
	elif player == "Player2" and green_car_speed <= 0.005:
		car_speed = green_car_speed
		green_car_speed += 0.001

func stop_accelerate(player: String):
	var car_speed: int

	if player == "Player1":
		if blue_car_speed > 0:
			car_speed = blue_car_speed
			blue_car_speed -= 0.00025
		else:
			blue_car_speed = 0
	elif player == "Player2":
		if green_car_speed > 0:
			car_speed = green_car_speed
			green_car_speed -= 0.00025
		else:
			green_car_speed = 0

func stop_car(player: String):
	if player == "Player1":
		blue_car_speed = 0
		blue_car_running = false
	elif player == "Player2":
		green_car_speed = 0
		green_car_running = false

func run_car(player: String):
	if player == "Player1":
		blue_car_running = true
	elif player == "Player2":
		green_car_running = true

func car_in_curve(player: String, pos: String):
	if player == "Player1":
		if blue_car_speed > 0.004:
			stop_car("Player1")
			if pos == "Right":
				blue_car_animation.play("DerailRight")
			elif pos == "Left":
				blue_car_animation.play("DerailLeft")

	if player == "Player2":
		if green_car_speed > 0.004:
			stop_car("Player2")
			if pos == "Right":
				green_car_animation.play("DerailRight")
			elif pos == "Left":
				green_car_animation.play("DerailLeft")

# Called every frame
func _process(delta: float):
	if blue_car_running:
		var blue_car_result = update_car(blue_car, blue_car_speed, blue_car_prev_offset, blue_car_laps)
		blue_car_prev_offset = blue_car_result[0]
		blue_car_laps = blue_car_result[1]
	if green_car_running:
		var green_car_result = update_car(green_car, green_car_speed, green_car_prev_offset, green_car_laps)
		green_car_prev_offset = green_car_result[0]
		green_car_laps = green_car_result[1]
	if blue_car_laps == LAP_TARGET or green_car_laps == LAP_TARGET:
		blue_car_running = false
		green_car_running = false
		if blue_car_laps == LAP_TARGET:
			print("Player 1 Win")
		elif green_car_laps == LAP_TARGET:
			print("Player 2 Win")
		set_process(false)

func update_car(car, car_speed, prev_offset, car_laps):
	var current_offset = car.unit_offset
	car.unit_offset += car_speed
	if current_offset < prev_offset:
		car_laps += 1
	prev_offset = current_offset
	return [prev_offset, car_laps]
