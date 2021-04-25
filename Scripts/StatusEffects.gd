extends Node2D

# Variables to store default values of parent
onready var parent = get_parent()
var defaultDef : Array
# References to effects
onready var shatterDefTimer = $ShatterDef/ShatterDefTimer
onready var shatterDefEffect = $ShatterDef

func InitEffectDefaults():
	defaultDef = parent.def

func AddEffect(effect):
	print(effect)
	match effect:
		"ShatterDef":
			shatterDefEffect.emitting = true
			shatterDefTimer.start()
			for i in range(defaultDef.size()):
				parent.def[i] = defaultDef[i]*0.1

func _on_ShatterDefTimer_timeout():
	shatterDefEffect.emitting = false
	for i in range(defaultDef.size()):
		parent.def[i] = defaultDef[i]
