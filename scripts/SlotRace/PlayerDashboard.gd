extends Node

onready var progress_bar_player = get_node("MarginContainer2/Stats/ProgressBar")
onready var laps_indicator = get_node("MarginContainer2/Stats/LapsIndicator")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func update_progress_bar(speed: float):
	var percentage: float = (speed * 100 / 0.6) * 100
	progress_bar_player.value = percentage
	
func update_laps_indicator(lap: int):
	laps_indicator.text = str(lap) + "/3"
