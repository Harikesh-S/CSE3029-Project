extends WeaponMelee

# Rotation and z index for each quadrant
export var rotation = [0,0,-90,90]
export var flip = [-1,1,-1,1]
export var relIndex = [3,3,-3,-3]
onready var scaleX = self.scale.x
# Dash streak resource
var streakRes = preload("res://Player/Weapons/Sword/DashStreak.tscn")
onready var dashReady = $DashReady
onready var dashStart = $DashStart

func DashReadyEffect(state) -> void:
	if(state):
		dashReady.show()
	else:
		dashReady.hide()

func DashStartEffect(state) -> void:
	dashStart.emitting = state

func _ready():
	dashStartTime = 0.2
	dashEndTime = 0.2
	dashReady.modulate = GetColor()
	dashStart.modulate = GetColor()

# Update the sprite based on where the player is facing
func UpdatePosition(quadrantIndex : int) -> void:
	self.rotation_degrees = rotation[quadrantIndex]
	self.scale.x = flip[quadrantIndex]*scaleX

func GetIndex(quadrantIndex : int) -> int:
	return relIndex[quadrantIndex]

func GetDashDistance() -> int:
	return 200
	
func GetDashDistanceSquared() -> int:
	return 40000

func GetDamage():
	return [50,true]

func GetColor() -> Color:
	return Color("#6dead6")

func GetMaxDash() -> int:
	return 5

func GetDashStreak(startPos : Vector2, endPos : Vector2):
	var streak = streakRes.instance()
	streak.startPos = startPos
	streak.endPos = endPos
	streak.time = self.dashEndTime
	return streak
