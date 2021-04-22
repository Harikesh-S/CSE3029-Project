# Class for all bullets
class_name Bullet
extends KinematicBody2D

signal hit_enemy(amount)

var velocity

func destroy() -> void:
	queue_free()

func hit() -> void:
	pass

func SetDirection(dir : Vector2,globalMousePos : Vector2) -> void:
	velocity = dir*GetSpeed()
	look_at(globalMousePos)

func GetDamage():
	return [0,false]

func GetSpeed() -> int:
	return 0

# Corresponds to the `_physics_process()` callback.
func _physics_process(delta: float) -> void:
	# Move and detect collisions
	if(move_and_collide(velocity*delta)):
		hit()
