extends Node2D

var testRes = preload("res://Test.tscn")

func _ready():
	Reset()
	Resolution()
# warning-ignore:return_value_discarded
	$CanvasLayer/VBoxContainer/Button.connect("pressed", self, "Fullscreen")
# warning-ignore:return_value_discarded
	$CanvasLayer/VBoxContainer/Button2.connect("pressed", self, "Resolution")
# warning-ignore:return_value_discarded
	$CanvasLayer/VBoxContainer/Button3.connect("pressed", self, "Heal")
# warning-ignore:return_value_discarded
	$CanvasLayer/VBoxContainer/Button4.connect("pressed", self, "Damage")
# warning-ignore:return_value_discarded
	$CanvasLayer/VBoxContainer/Button6.connect("pressed", self, "DamageCrit")
# warning-ignore:return_value_discarded
	$CanvasLayer/VBoxContainer/Button5.connect("pressed", self, "Reset")

func _process(_delta):
	if(Input.is_action_just_pressed("debug")):
		$CanvasLayer/VBoxContainer.visible = !$CanvasLayer/VBoxContainer.visible
		$CanvasLayer/VBoxContainer2.visible = !$CanvasLayer/VBoxContainer2.visible

func _physics_process(_delta):
	$CanvasLayer/VBoxContainer2/Label.text = "FPS: " + str(Performance.get_monitor(Performance.TIME_FPS))
	$CanvasLayer/VBoxContainer2/Label2.text = "Memory Static: " + str(round(Performance.get_monitor(Performance.MEMORY_STATIC)/1024/1024)) + " MB"

func ClearScreen():
	for child in $Node2D.get_children():
		$Node2D.remove_child(child)
		child.queue_free()

func Test():
	var test = testRes.instance()
	$Node2D.add_child(test)

func Fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen

func Resolution():
	if(OS.window_fullscreen):
		return
	if(get_viewport().size!=Vector2(1280,720)):
		OS.set_window_size(Vector2(1280,720))
	else:
		OS.set_window_size(Vector2(640,360))

func Damage():
	var player = get_node("Node2D/Node2D/YSort/Player")
	if(player):
		player.OnHit([10,false])

func DamageCrit():
	var player = get_node("Node2D/Node2D/YSort/Player")
	if(player):
		player.OnHit([20,true])
	
func Heal():
	var player = get_node("Node2D/Node2D/YSort/Player")
	if(player):
		player.OnHeal(50)
	
	
func Reset():
	ClearScreen()
	Test()
