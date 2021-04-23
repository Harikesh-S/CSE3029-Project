extends Sprite

var time := 0.0
onready var orig_scale : Vector2 = scale
export var power := 0.5
export var speed := 5.0

func _process(delta):
	time = wrapf(time+delta*speed, -PI,PI)
	scale = orig_scale + Vector2.ONE*(sin(time) * power)
