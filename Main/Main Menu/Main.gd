# Main menu 
# Button signals are connected using the editor

extends Node2D

func _ready():
	pass

func _on_New_Game_button_up():
	get_node("../../").LoadLevelName("Cutscene1")

func _on_Exit_button_up():
	get_node("../../").Exit()

func _on_Options_button_up():
	pass # Replace with function body.

func _on_Help_button_up():
	pass # Replace with function body.
