# Class for all bullets
class_name Bullet
extends KinematicBody2D

# warning-ignore:unused_signal
signal hit_enemy(amount)

var velocity : Vector2
var mousePos : Vector2

func Destroy() -> void:
	queue_free()

func Hit() -> void:
	pass

func SetDirection(dir : Vector2,globalMousePos : Vector2) -> void:
	velocity = dir*GetSpeed()
	mousePos = globalMousePos

func GetSpeed() -> int:
	return 0

func _ready():
	look_at(mousePos)

func _physics_process(delta: float) -> void:
	# Move and detect collisions
	if(move_and_collide(velocity*delta)):
		Hit()
