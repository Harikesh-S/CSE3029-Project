# Virtual base class for all weapons.
class_name WeaponMelee
extends Node

var dashStartTime : float = 0.1
var dashEndTime : float = 0.1

# Virtual function. Receives quadrant that the player is facing
# 0 - Right, 1 - Left, 2 - Right-Back, 3 - Left-Back
func UpdatePosition(_quadrantIndex : int) -> void:
	pass

# Virtual function to return the relative index for ordering
func GetIndex(_quadrant: int) -> int:
	return 0

# Virtual function to return dash distance for current melee weapon
func GetDashDistance() -> int:
	return 0

# Virtual function to return dash distance squared for current melee weapon
func GetDashDistanceSquared() -> int:
	return 0

# Virtual function to return dash damage for current melee weapon
func GetDamage():
	return [0,false]

# Virtual function to create and return a dash streak
func GetDashStreak(startPos : Vector2, endPos : Vector2, mousePos : Vector2):
	return null

# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	pass

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass
