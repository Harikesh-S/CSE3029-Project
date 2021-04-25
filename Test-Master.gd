extends Node2D

var levels = [preload("res://Test.tscn"),preload("res://Test-V2.tscn"),
preload("res://Test-Defense.tscn"),preload("res://Test-Damage.tscn"),
preload("res://Test-DashReset.tscn")]
var currLevel = 0

func _ready():
	Reset()
	Resolution()
# warning-ignore:return_value_discarded
	$CanvasLayer/VBoxContainer/Button.connect("pressed", self, "Fullscreen")
# warning-ignore:return_value_discarded
	$CanvasLayer/VBoxContainer/Button2.connect("pressed", self, "Resolution")
# warning-ignore:return_value_discarded
	$CanvasLayer/VBoxContainer/Button5.connect("pressed", self, "Reset")
# warning-ignore:return_value_discarded
	$CanvasLayer/VBoxContainer/Button7.connect("pressed", self, "NextLevel")
# warning-ignore:return_value_discarded
	$CanvasLayer/VBoxContainer/Button8.connect("pressed", self, "PrevLevel")

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
		player.OnHit([10,1,0,false])

func DamageCrit():
	var player = get_node("Node2D/Node2D/YSort/Player")
	if(player):
		player.OnHit([20,1,1,false])
	
func Heal():
	var player = get_node("Node2D/Node2D/YSort/Player")
	if(player):
		player.OnHeal(50)
	
	
func Reset():
	$CanvasLayer/VBoxContainer/Label.text = "Level: "+str(currLevel+1) +"/"+str(levels.size())
	ClearScreen()
	LoadLevel()

func NextLevel():
	currLevel+=1
	if(currLevel>=levels.size()):
		currLevel = levels.size()-1
	Reset()

func PrevLevel():
	currLevel-=1
	if(currLevel<0):
		currLevel = 0
	Reset()
	

func LoadLevel():
	var level = levels[currLevel].instance()
	$Node2D.add_child(level)
