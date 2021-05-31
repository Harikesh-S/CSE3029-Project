# Main menu 
# Button signals are connected using the editor

extends Node2D

func _ready():
	$CanvasLayer/Options.root = get_node("../../")
	$CanvasLayer/Options.Update()

func _on_New_Game_button_up():
	$Select.play()
	get_node("../../").score = 0
	get_node("../../").LoadLevelName("Cutscene1")

func _on_Exit_button_up():
	$Select.play()
	get_node("../../").Exit()

func _on_Options_button_up():
	$Select.play()
	$CanvasLayer/Options.Update()
	$CanvasLayer/Options.show()
