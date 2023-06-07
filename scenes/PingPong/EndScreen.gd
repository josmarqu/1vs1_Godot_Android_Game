extends Control

func _ready():
	
	$Label.text = $Label.text%[GlobalAttributes.winner]
	$WinnerSound.play()
	yield($WinnerSound,"finished")
	yield(get_tree().create_timer(4),"timeout")
	get_tree().change_scene("res://scenes/PingPong/Nivel/Level.tscn")
	



	
