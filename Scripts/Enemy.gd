# Class for all enemies
class_name Enemy
extends KinematicBody2D

var floatingTextRes = preload("res://Scenes/FloatingText.tscn")

var health : float
var maxHealth : float
var def : Array
var alive : bool = true

onready var animationPlayer = $AnimationPlayer
onready var area2D = $Area2D
onready var healthBar = $HealthBar
onready var effects = $StatusEffects

func Start():
	effects.InitEffectDefaults()
	health = maxHealth
	animationPlayer.play("Idle")
	animationPlayer.connect("animation_finished",self,"AnimationFinished")
	healthBar.UpdateValue(health/maxHealth)

func AnimationFinished(animationName : String):
	if(animationName=="Hit"):
		animationPlayer.play("Idle")
	if(animationName=="Death"):
		queue_free()

func Die():
	effects.visible = false
	animationPlayer.play("Death")
	$CollisionShape2D.set_deferred("disabled",true)
	$Area2D/CollisionShape2D.set_deferred("disabled",true)
	alive = false

func OnEffect(effectName) -> void:
	effects.AddEffect(effectName)

func OnHit(damage) -> void:
	# damage = [ value, type, crit?, melee? ]
	if !alive:
		return
	# Damage calculation 
	var amount = int(damage[0]*(1-def[damage[1]]))
	var floatingText = floatingTextRes.instance()
	floatingText.amount = amount
	floatingText.type = damage[1] # Type
	floatingText.crit = damage[2] # Crit
	add_child(floatingText)
	self.health -= amount
	animationPlayer.play("Hit")
	healthBar.UpdateValue(health/maxHealth)
	if(health <= 0):
		Die()
		if damage[3] == true: # Was killed by a melee attack, send signal
			get_parent().DashKill()

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass
