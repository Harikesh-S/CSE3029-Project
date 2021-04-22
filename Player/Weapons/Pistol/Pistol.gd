extends Weapon

# Z index of weapon based on player quadrant
export var relIndex = [1,1,-1,-1]
# Used to flip the weapon
export var scaleRight = Vector2(0.5,0.5)
onready var scaleLeft = Vector2(
	scaleRight.x*-1,scaleRight.y)
# Used to track mouse cursor
var relativeMousePos
var xAxis = Vector2(1,0)
# References
onready var barrelEnd = $Weapon/End
onready var weapon = $Weapon
onready var nextShot = $NextShot
# Minimum distance of input from the weapon
onready var minDist = (barrelEnd.position.x*5)
onready var minDistSq = pow(minDist,2)
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
	if weapon.global_position.distance_squared_to(globalMousePos) < minDistSq:
		relativeMousePos = barrelEnd.global_position.direction_to(
			weapon.global_position + minDist*weapon.global_position.direction_to(globalMousePos))
	else:
		relativeMousePos = barrelEnd.global_position.direction_to(globalMousePos)
	weapon.rotation = acos(xAxis.dot((relativeMousePos).normalized()))
	if((relativeMousePos).y<0):
		weapon.rotation *= -1

func GetIndex(quadrantIndex : int) -> int:
	return relIndex[quadrantIndex]

func ReadyToShoot() -> bool:
	if(nextShot.time_left>0):
		return false
	return true
	
func Shoot(globalMousePos: Vector2) -> Bullet:
	nextShot.start()
	var bullet = bulletRes.instance()
	bullet.global_position = barrelEnd.global_position
	bullet.SetDirection(barrelEnd.global_position.direction_to(globalMousePos),globalMousePos)
	return bullet
