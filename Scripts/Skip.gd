# Skip cutscene menu
extends CanvasLayer

# Show and hide
onready var menu = $Menu
func show():
	menu.show()
func hide():
	menu.hide()

func _on_No_button_up():
	get_parent().ResumeScene()

func _on_Yes_button_up():
	get_parent().ResumeScene()
	get_node("../../../").LoadLevelName("Space-L1")
