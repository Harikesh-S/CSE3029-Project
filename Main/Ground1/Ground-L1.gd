extends Node2D

# Pausing
onready var pause = $Pause
func _input(event):
	if(event.is_action_pressed("esc")):
			pause.show()
			get_tree().paused = true
func ResumeGame():
	pause.hide()
	get_tree().paused = false


func _ready():
	pass
