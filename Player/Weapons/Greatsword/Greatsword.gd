extends WeaponMelee

# Rotation and z index for each quadrant
export var rotation = [0,0,0,0]
export var flip = [1,-1,1,-1]
export var relIndex = [-3,-3,3,3]
# Dash streak resource
var streakRes = preload("res://Player/Weapons/Greatsword/DashStreak.tscn")
onready var dashReady = $DashReady
onready var dashStart = $DashStart
onready var scaleX = self.scale.x

func _ready():
	dashStartTime = 0.5
	dashEndTime = 0.5
	dashReady.modulate = GetColor()
	dashStart.modulate = GetColor()

# Update the sprite based on where the player is facing
func UpdatePosition(quadrantIndex : int) -> void:
	self.rotation_degrees = rotation[quadrantIndex]
	self.scale.x = flip[quadrantIndex]*scaleX

func GetIndex(quadrantIndex : int) -> int:
	return relIndex[quadrantIndex]

func GetDashDistance() -> int:
	return 100
	
func GetDashDistanceSquared() -> int:
	return 10000

func GetColor() -> Color:
	return Color("#ec273f")

func GetDashMax() -> int:
	return 8

func GetDashStreak(startPos : Vector2, endPos : Vector2, mousePos : Vector2):
	var streak = streakRes.instance()
	streak.startPos = startPos
	streak.endPos = endPos
	streak.mousePos = mousePos
	return streak
