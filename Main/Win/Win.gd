extends Node2D


func _ready():
	$Label3.text = "Score : "+str(get_node("../../").score)
	pass


func _on_Retry_button_up():
	$Select.play()
	get_node("../../").score=0
	get_node("../../").LoadLevelName("Cutscene1")
	


func _on_Menu_button_up():
	$Select.play()
	get_node("../../").score=0
	get_node("../../").LoadLevelName("Main")
