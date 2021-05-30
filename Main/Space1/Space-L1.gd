extends Node2D


func _ready():
	pass


func _on_Death_button_up():
	get_node("../../").LoadLevelName("Death")


func _on_Next_button_up():
	get_node("../../").LoadLevelName("Ground-L1")
