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

# Virtual function to create and return a dash streak
func GetDashStreak(_startPos : Vector2, _endPos : Vector2):
	return null

# Virtual function to get dash max (recharge)
func GetMaxDash() -> int:
	return 1

# Virtual function to return color associated with the weapon
func GetColor() -> Color:
	return Color(1,1,1,1)


# Virtual functions to show effects (ready and just before dash)
func DashReadyEffect(_state) -> void:
	pass

func DashStartEffect(_state) -> void:
	pass

# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	pass

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass
