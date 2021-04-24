extends Weapon

# Z index of weapon based on player quadrant
export var relIndex = [1,1,-1,-1]
# Used to flip the weapon
onready var scaleRight = self.scale
onready var scaleLeft = Vector2(
	scaleRight.x*-1,scaleRight.y)
# Used to track mouse cursor
var relativeMousePos
var xAxis = Vector2(1,0)
# References
onready var barrelEnd = $Weapon/End
onready var weapon = $Weapon
onready var nextShot = $NextShot
onready var reloadTimer = $ReloadTimer
# Minimum distance of input from the weapon
onready var minDist = (barrelEnd.position.x*5)
onready var minDistSq = pow(minDist,2)
# Ammo
onready var maxAmmo = 6
onready var ammo = 6
# preloading bullet
var bulletRes = preload("res://Player/Weapons/Pistol/Bullet.tscn")


func UpdatePosition(globalMousePos: Vector2) -> void:
	# X axis flip
	if (globalMousePos-weapon.global_position).x<0:
		self.scale = scaleLeft
		xAxis.x = -1
	else:
		self.scale = scaleRight
		xAxis.x = 1
	# Track mouse cursor from barrel, get vector from base of weapon
	# Move point if the point is too close
	relativeMousePos = barrelEnd.global_position.direction_to(MinDistPoint(globalMousePos))
	weapon.rotation = acos(xAxis.dot((relativeMousePos).normalized()))
	if((relativeMousePos).y<0):
		weapon.rotation *= -1

func MinDistPoint(globalMousePos: Vector2) -> Vector2:
	if weapon.global_position.distance_squared_to(globalMousePos) < minDistSq:
		return weapon.global_position + minDist*weapon.global_position.direction_to(globalMousePos)
	else:
		return globalMousePos

func GetIndex(quadrantIndex : int) -> int:
	return relIndex[quadrantIndex]

func ReadyToShoot() -> bool:
	if(nextShot.time_left>0):
		return false
	if(ammo<=0):
		return false
	return true

func Reload() -> void:
	if(reloadTimer.time_left>0):
		return
	if(ammo == maxAmmo):
		return
	reloadTimer.start()

func CancelReload() -> void:
	reloadTimer.stop()

func ReloadComplete() -> void:
	ammo = maxAmmo

func Shoot(globalMousePos: Vector2) -> Bullet:
	ammo -= 1
	nextShot.start()
	var bullet = bulletRes.instance()
	bullet.global_position = barrelEnd.global_position
	bullet.SetDirection(
		barrelEnd.global_position.direction_to(MinDistPoint(globalMousePos)),
		MinDistPoint(globalMousePos))
	return bullet
