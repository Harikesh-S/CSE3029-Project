extends Button

func _ready():
	connect("pressed", self, "on_button_press")
func on_button_press():
	OS.window_fullscreen = !OS.window_fullscreen

func _process(delta):
	self.text = str(get_viewport().size.x)+", "+str(get_viewport().size.y)
