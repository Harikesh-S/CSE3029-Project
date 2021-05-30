extends Node2D


func _ready():
	pass


func _on_Death_button_up():
	get_node("../../").LoadLevelNo(5)


func _on_Next_button_up():
	get_node("../../").LoadLevelNo(3)
