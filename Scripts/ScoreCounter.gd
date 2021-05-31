extends CanvasLayer

onready var root = get_node("../../../")
onready var label = $Label

func _process(_delta):
	label.text = "Score: "+str(root.score)
