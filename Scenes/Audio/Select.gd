extends Node2D


func play():
	if(get_tree().current_scene.audio):
		$AudioStreamPlayer2D.play()
#
#func playTutorial():
#	print("play")
#	if(get_node("../../../../../").audio):
#		$AudioStreamPlayer2D.play()
