extends Node2D

var time = 0

# Pausing
onready var pause = $Pause
func _input(event):
	if(event.is_action_pressed("esc")):
			$Select.play()
			pause.show()
			get_tree().paused = true
func ResumeGame():
	pause.hide()
	get_tree().paused = false

func Win():
	var time_score = (200 - time)*10
	if(time_score<0):
		time_score=0
	print("Time score - ground level :"+str(time_score))
	get_node("../../").score += time_score
	get_node("../../").LoadLevelName("Win")


func _on_ScoreTimer_timeout():
	time += 1

