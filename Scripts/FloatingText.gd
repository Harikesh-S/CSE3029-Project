extends Position2D

onready var label = $Label
onready var tween = $Tween

var amount = 0
var type = "ED"
const COLORS = {
	"ED":Color("f7f3b7"),	# Enemy damage
	"EDC":Color("ec273f"),	# Enemy damage crit
	"PD":Color("e98537"),	#Player damage
	"PDC":Color("ec273f"),	#Player damage crit
	"PH":Color("5ab552"),	#Player heal
}

func _ready():
	label.set_text(str(amount))
	label.set("custom_colors/font_color",COLORS[type])
	tween.interpolate_property(self, 'scale', scale, Vector2(0.5,0.5), 0.2, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(self, 'position', position, position + Vector2(10,-50), 1, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.interpolate_property(self, 'scale', Vector2(0.5,0.5), Vector2(0.05,0.05), 0.7, Tween.TRANS_QUAD, Tween.EASE_OUT, 0.3)
	tween.start()


func _on_Tween_tween_all_completed():
	self.queue_free()
