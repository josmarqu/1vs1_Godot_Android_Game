extends Control

#onready var winnerColor: ColorRect = get_node("BgColor")

func _ready():
	
	if GlobalAttributes.winner == "Red":
		$BgColor.color = Color("C13030")
		GlobalAttributes.red_score += 1
	elif GlobalAttributes.winner == "Blue":
		$BgColor.color = Color("248C80")
		GlobalAttributes.blue_score += 1
		
	$Label.text = $Label.text%[GlobalAttributes.winner]
	$WinnerSound.play()
	yield($WinnerSound,"finished")

	yield(get_tree().create_timer(4),"timeout")
	get_tree().change_scene("res://scenes/GameSelector.tscn")
	

	

	
		
		
		
		
		
	



	
