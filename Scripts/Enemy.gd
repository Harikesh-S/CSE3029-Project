# Class for all enemies
class_name Enemy
extends KinematicBody2D

var floatingTextRes = preload("res://Scenes/FloatingText.tscn")

var health : float
var maxHealth : float
var alive : bool = true

onready var animationPlayer = $AnimationPlayer
onready var area2D = $Area2D
onready var healthBar = $HealthBar

func Start():
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
	animationPlayer.play("Death")
	$CollisionShape2D.disabled = true
	$Area2D/CollisionShape2D.disabled = true
	alive = false

func OnHit(damage) -> void:
	if !alive:
		return
	var floatingText = floatingTextRes.instance()
	floatingText.amount = damage[0]
	if(damage[1]): # Crit
		floatingText.type = "EDC"
	else:
		floatingText.type = "ED"
	add_child(floatingText)
	self.health -= damage[0]
	animationPlayer.play("Hit")
	healthBar.UpdateValue(health/maxHealth)
	if(health <= 0):
		Die()
		if damage[2] == true: # Was killed by a melee attack, send signal
			get_parent().DashKill()

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass
