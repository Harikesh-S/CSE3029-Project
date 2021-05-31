extends Node2D
var  counter = 5

var time = 0


func die_enemy():
	get_node("../../").score += 100
	counter -= 1
	if(counter == 0):
		var time_score = (200 - time)*10
		if(time_score<0):
			time_score=0
		print("Time score - space level :"+str(time_score))
		get_node("../../").score += time_score
		get_node("../../").LoadLevelName("Ground-L1") 

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


func _on_ScoreTimer_timeout():
	time += 1


var tutorial = preload("res://Scenes/Tutorials/S1-T1.tscn")

func _on_TutorialTimer_timeout():
	if(get_node("../../").tutorials):
		print("Space tutorial")
		var t = tutorial.instance()
		$Tutorials.add_child(t)
		get_tree().paused = true
