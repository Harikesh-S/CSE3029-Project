extends Position2D

var startPos
var endPos
var mousePos

func Destroy():
	queue_free()

func GetDamage():
	return [100,true]


func _ready():
	var tween = $Tween
	self.global_position = startPos
	self.look_at(mousePos)
	tween.interpolate_property(self,'global_position',startPos,endPos,0.1,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	tween.start()
	tween.connect("tween_all_completed",self,"Destroy")
