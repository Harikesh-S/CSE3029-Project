extends Position2D

onready var label = $Label
onready var tween = $Tween

var amount = 0
var type : int
var crit : int = 0

# Fill and outline colors for each damage type non crit and crit
const TYPES = [
	# Yellow
	[[Color("f7f3b7"),Color("10121c")],[Color("f3a833"),Color("10121c")]],
	# Cyan 
	[[Color("6dead6"),Color("b0a7b8")],[Color("6dead6"),Color("10121c")]],
	# Red
	[[Color("6b2643"),Color("ffa2ac")],[Color("ec273f"),Color("10121c")]],
	# Violet
	[[Color("deceed"),Color("3e3b65")],[Color("3e3b65"),Color("10121c")]],
	# Heal
	[[Color("5ab552"),Color("10121c")]]
]
# Scale text more if it is a crit
const SCALE = [ Vector2(0.5,0.5), Vector2(0.7,0.7) ]
const HOLD = [0.4, 0.5]

func _ready():
	label.set_text(str(amount))
	label.set("custom_colors/font_color",TYPES[type][crit][0])
	label.set("custom_colors/font_outline_modulate",TYPES[type][crit][1])
	tween.interpolate_property(self, 'scale', null, SCALE[crit], 0.3, 
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(self, 'scale', null, Vector2.ZERO, 0.2, 
		Tween.TRANS_QUAD, Tween.EASE_OUT, 0.3)
	tween.interpolate_property(self, 'position', position, position + 
	Vector2(rand_range(-15.0,15.0),-70), 1, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()


func _on_Tween_tween_all_completed():
	self.queue_free()
