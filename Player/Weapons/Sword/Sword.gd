extends WeaponMelee

# Rotation and z index for each quadrant
export var rotation = [90,180,0,270]
export var relIndex = [-3,-3,3,3]
# Dash streak resource
var streakRes = preload("res://Player/Weapons/Sword/DashStreak.tscn")

func _ready():
	dashStartTime = 0.2
	dashEndTime = 0.2

# Update the sprite based on where the player is facing
func UpdatePosition(quadrantIndex : int) -> void:
	self.rotation_degrees = rotation[quadrantIndex]

func GetIndex(quadrantIndex : int) -> int:
	return relIndex[quadrantIndex]

func GetDashDistance() -> int:
	return 200
	
func GetDashDistanceSquared() -> int:
	return 40000

func GetDamage():
	return [100,true]

func GetColor() -> Color:
	return Color("#6dead6")

func GetDashMax() -> int:
	return 5

func GetDashStreak(startPos : Vector2, endPos : Vector2, mousePos : Vector2):
	var streak = streakRes.instance()
	streak.startPos = startPos
	streak.endPos = endPos
	streak.mousePos = mousePos
	return streak
