extends Node

onready var btn_player1 = get_node("UI/Components/Player1MarginArea/Player1ControlPanel/Player1Button")
onready var race_world = get_node("RaceWorld")

# Called when the node enters the scene tree for the first time.
func _ready():
	button_listener()

# Make an action depend of the button pressed
func on_button_pressed(button: Button):
	if button == btn_player1:
		race_world.accelerate("blue_car")

# listener for all the game buttons
func button_listener():
	btn_player1.connect("pressed", self, "on_button_pressed", [btn_player1])
