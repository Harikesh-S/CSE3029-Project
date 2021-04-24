# Virtual base class for all weapons.
class_name Weapon
extends Node2D

# Virtual function. Receives mouse position from Player
func UpdatePosition(globalMousePos: Vector2) -> void:
	pass

# Virtual function to return the relative index for ordering
func GetIndex(quadrant: int) -> int:
	return 0

# Virtual function to check if the weapon is ready to shoot
func ReadyToShoot() -> bool:
	return false

# Virtual function to shoot and return the bullet instance
func Shoot(globalMousePos: Vector2) -> Bullet:
	return null

# Virtual function to return a point on the minimum distance circle if the input is too close
func MinDistPoint(globalMousePos: Vector2) -> Vector2:
	return globalMousePos

# Virtual function for action on reload timer completion
func ReloadComplete() -> void:
	pass

# Virtual function to start reload
func Reload() -> void:
	pass

# Virtual function to instant reload (for dash kills)
func InstantReload() -> void:
	pass

# Virtual function to cancel reload 
func CancelReload() -> void:
	pass

# Function to return UI name
func GetUI() -> String:
	return self.name+"-UI"

func _ready():
	# Connect reload timer signal
	$ReloadTimer.connect("timeout",self,"ReloadComplete")

# Virtual function. Corresponds to the `_process()` callback.
func update() -> void:
	pass

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(delta: float) -> void:
	pass
