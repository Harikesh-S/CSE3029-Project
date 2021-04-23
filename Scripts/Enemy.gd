# Class for all enemies
class_name Enemy
extends KinematicBody2D

var floatingTextRes = preload("res://Scenes/FloatingText.tscn")

var health : float
var maxHealth : float

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

func OnHit(damage) -> void:
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

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass
