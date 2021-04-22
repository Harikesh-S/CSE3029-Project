# Virtual base class for all weapons.
class_name Weapon
extends Node2D

# Virtual function. Receives mouse position from Player
func UpdatePosition(_globalMousePos: Vector2) -> void:
	pass

# Virtual function to return the relative index for ordering
func GetIndex(_quadrant: int) -> int:
	return 0

# Virtual function to check if the weapon is ready to shoot
func ReadyToShoot() -> bool:
	return false

# Virtual function to shoot and return the bullet instance
func Shoot(_globalMousePos: Vector2) -> Bullet:
	return null

# Virtual function. Corresponds to the `_process()` callback.
func update() -> void:
	pass

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass
