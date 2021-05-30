# Main menu 
# Button signals are connected using the editor

extends Node2D

func _ready():
	pass

func _on_New_Game_button_up():
	get_node("../../").LoadLevelNo(1)


func _on_Exit_button_up():
	get_node("../../").Exit()
