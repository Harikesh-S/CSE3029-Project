# Class for all enemies
class_name Enemy
extends KinematicBody2D

var floatingTextRes = preload("res://Scenes/FloatingText.tscn")

var animationPlayer : AnimationPlayer
var health : int
var area2D : Area2D

func Start():
	animationPlayer.play("Idle")
	animationPlayer.connect("animation_finished",self,"AnimationFinished")
	area2D.connect("area_entered",self,"AreaEntered")

func AreaEntered(area : Area2D):
	OnHit(area.get_parent().GetDamage())

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
	print(health)
	animationPlayer.play("Hit")

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass
