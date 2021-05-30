extends Node2D


func _ready():
	pass


func _on_Death_button_up():
	get_node("../../").LoadLevelNo(5)


func _on_Win_button_up():
	get_node("../../").LoadLevelNo(4)
