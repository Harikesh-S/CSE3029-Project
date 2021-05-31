# Pause menu

extends CanvasLayer

# Show and hide
onready var menu = $Menu
func show():
	menu.show()
func hide():
	menu.hide()

func _ready():
	$Options.root = get_node("../../../")

# Unpause
func _on_Resume_button_up():
	$Select.play()
	get_parent().ResumeGame()

# Options
func _on_Options_button_up():
	$Select.play()
	$Options.Update()
	$Options.show()

# Quit
func _on_Main_button_up():
	$Select.play()
	get_parent().ResumeGame()
	get_node("../../../").LoadLevelName("Main")
