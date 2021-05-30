extends Node2D


func _ready():
	pass


func _on_Retry_button_up():
	# CALL FUNCTION TO RESEST SCORE HERE ----------------------------------
	
	get_node("../../").LoadLevelName("Cutscene1")
	


func _on_Menu_button_up():
	
	get_node("../../").LoadLevelName("Main")
