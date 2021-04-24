extends Node2D

var testRes = preload("res://Test.tscn")

func _ready():
	Reset()
	Resolution()
	$CanvasLayer/VBoxContainer/Button.connect("pressed", self, "Fullscreen")
	$CanvasLayer/VBoxContainer/Button2.connect("pressed", self, "Resolution")
	$CanvasLayer/VBoxContainer/Button3.connect("pressed", self, "Heal")
	$CanvasLayer/VBoxContainer/Button4.connect("pressed", self, "Damage")
	$CanvasLayer/VBoxContainer/Button6.connect("pressed", self, "DamageCrit")
	$CanvasLayer/VBoxContainer/Button5.connect("pressed", self, "Reset")

func _process(delta):
	if(Input.is_action_just_pressed("debug")):
		$CanvasLayer/VBoxContainer.visible = !$CanvasLayer/VBoxContainer.visible

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
