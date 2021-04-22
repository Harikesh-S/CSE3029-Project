extends Position2D

onready var label = $Label
onready var tween = $Tween

var amount = 0
var type = "ED"
const COLORS = {
	"ED":Color("f7f3b7"),	# Enemy damage
	"EDC":Color("ec273f"),	# Enemy damage crit
}

func _ready():
	label.set_text(str(amount))
	label.set("custom_colors/font_color",COLORS[type])
	tween.interpolate_property(self, 'scale', scale, Vector2(0.5,0.5), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property(self, 'position', position, position + Vector2(0,-30), 1, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.interpolate_property(self, 'scale', Vector2(0.5,0.5), Vector2(0.05,0.05), 0.7, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.3)
	tween.start()


func _on_Tween_tween_all_completed():
	self.queue_free()