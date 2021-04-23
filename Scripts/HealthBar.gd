extends Control

onready var bar = $Bars/TextureProgress
onready var redBar = $Bars/TextureProgressRed
onready var tween = $Tween
onready var animation = $AnimationPlayer
# Used to change the color of the bar
const COLORS = [Color("26854c"),Color("f3a833"),Color("de5d3a"),Color("ec273f")]
var endColor

func UpdateValue(ratio):
	if(ratio>0.7):
		endColor = COLORS[0]
	elif(ratio>0.5):
		endColor = COLORS[1]
	elif(ratio>0.2):
		endColor = COLORS[2]
	else:
		endColor = COLORS[3]
	var value = int(ratio * 100)
	tween.remove_all()
	if(value>bar.value):
		# Healing, just increase values
		tween.interpolate_property(bar,"value",null,value,0.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
		tween.interpolate_property(redBar,"value",null,value,0.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	else:
		# Taking damage
		animation.play("shake")
		tween.interpolate_property(bar,"tint_over",null,Color(1,1,1),0.1,Tween.TRANS_EXPO,Tween.EASE_OUT)
		tween.interpolate_property(bar,"value",null,value,0.1,Tween.TRANS_QUAD,Tween.EASE_OUT)
		tween.interpolate_property(redBar,"value",null,value,0.5,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.interpolate_property(bar,"tint_over",null,Color(0,0,0),0.1,Tween.TRANS_EXPO,Tween.EASE_OUT,0.1)
	tween.interpolate_property(bar,"tint_progress",null,endColor,0.2,Tween.TRANS_QUAD,Tween.EASE_OUT)
	if(ratio<=0):
		# Entity has died, remove health bar
		tween.interpolate_property($Bars,"rect_scale:x",null,0,1,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.start()
