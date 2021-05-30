# Pause menu

extends CanvasLayer

# Show and hide
onready var menu = $Menu
func show():
	menu.show()
func hide():
	menu.hide()

# Unpause
func _on_Resume_button_up():
	get_parent().ResumeGame()

# Options
func _on_Options_button_up():
	pass # Replace with function body.

# Help
func _on_Help_button_up():
	pass # Replace with function body.

# Quit
func _on_Main_button_up():
	get_node("../../../").LoadLevelName("Main")
