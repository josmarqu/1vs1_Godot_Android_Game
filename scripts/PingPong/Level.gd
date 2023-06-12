extends Node

var Pj1Score = 0
var Pj2Score = 0
const EndScreenScene = preload("res://scenes/EndScreen.tscn")
export var MaxPoint = 7
onready var scene_pause: String = "res://scenes/Pause.tscn"
var paused: Object = null

	
func _on_TopWall_body_entered(body):
	Pj1Score += 1
	pj_score()
	

	
func _on_BottonWall_body_entered(body):
	Pj2Score += 1
	pj_score()
	
func go_to_end_screen():
	get_tree().change_scene_to(EndScreenScene)
	
	
func _process(delta):    
	$Pj1Score.text = str(Pj1Score)
	$Pj2Score.text = str(Pj2Score)
	$Countdown.text = str(int($BallTimer.time_left) + 1)
		
func pj_score():
	$Ball.position = Vector2(700 / 2, 1200 / 2)
	get_tree().call_group('BallGroup', 'stop_ball')
	$BallTimer.start()
	$Countdown.visible = true
	$PointSound.play()
	$Player1.position.x = 438
	$Player2.position.x = 713


	if Pj1Score == MaxPoint or Pj2Score == MaxPoint:
		if Pj2Score == MaxPoint:
			GlobalAttributes.winner = "Red"
		else:
			GlobalAttributes.winner = "Blue"
		go_to_end_screen()
	
	

func _on_BallTimer_timeout():
	get_tree().call_group('BallGroup','restart_ball')
	$Countdown.visible = false


func _on_PauseButton_pressed():
	if paused == null:
		paused = load(scene_pause).instance()
		$PauseLayer.add_child(paused)
		paused.connect("p", self, "on_paused_quit")
		get_tree().paused = true
		
func on_paused_quit() -> void:
	paused = null
	pass

