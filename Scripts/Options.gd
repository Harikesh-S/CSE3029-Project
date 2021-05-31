# Options menu

extends Node2D

var root : Node2D

func Update():
	
	if(get_viewport().size==Vector2(1280,720)):
		$Menu/Resolution.pressed = true
		
	$Menu/Tutorials.pressed = root.tutorials
	$Menu/Audio.pressed = root.audio


func _on_Resolution_button_up():
	$Select.play()
	root.Resolution()
	$Menu/Resolution.pressed = !$Menu/Resolution.pressed


func _on_Audio_button_up():
	root.audio = !root.audio
	$Menu/Audio.pressed = root.audio
	$Select.play()


func _on_Tutorials_button_up():
	$Select.play()
	root.tutorials = !root.tutorials
	$Menu/Tutorials.pressed = root.tutorials


func _on_Close_button_up():
	$Select.play()
	self.hide()
