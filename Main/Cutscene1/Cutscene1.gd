# Intro cutscene
# Played using animation player node
# User input possible with functions as shown below

extends Node2D


onready var skip = $Skip
onready var animationPlayer = $AnimationPlayer

func _ready():
	animationPlayer.play("main") # Replace with name of first animation

func _input(event):
	if event.is_action_pressed("select"):
		if(animationPlayer.is_playing() == false):
			# Resume
			animationPlayer.play()
	# Skipping
	if(event.is_action_pressed("esc")):
			skip.show()
			get_tree().paused = true

# Used by skip menu
func ResumeScene():
	skip.hide()
	get_tree().paused = false

func Pause_Main_Animation():
	animationPlayer.stop(false)

func _on_AnimationPlayer_animation_finished(anim_name):
	match(anim_name):
		"main":
			$AnimationPlayer.stop()
			get_node("../../").LoadLevelName("Space-L1")
