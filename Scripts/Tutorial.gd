
extends ColorRect


func _on_Close_button_up():
	get_node("../../").ResumeGame();
	get_node("../../Select").play()
	queue_free()
