extends KinematicBody2D

# signals
signal health_updated(healthRatio)
signal dash_updated(dashRatio)

# Movement velocity
var velocity = Vector2(0,0)
# Variables used for updating animations
var globalMousePos
var relativeMousePosition
var quadrantIndex
var bodyAnimations = ["Right","Left","Right-Back","Left-Back"]
# Variables for weapons
export var initialMeleeWeapon = NodePath("Parts/Melee Weapons/Sword")
onready var currentMeleeWeapon = get_node(initialMeleeWeapon)
export var initialRangedWeapon = NodePath("Parts/Ranged Weapons/Pistol")
onready var currentRangedWeapon = get_node(initialRangedWeapon)
onready var dashMax = currentMeleeWeapon.GetDashMax()
onready var dashCount = dashMax

func _ready():
	pass

func _process(delta):
	# Track mouse cursor
	# Update body and melee animation 
	UpdateBodyAnimation()
	# Update the current weapon to aim towards the cursor
	currentRangedWeapon.UpdatePosition(globalMousePos)

func _physics_process(delta):
	move_and_slide(velocity)

func ShootWeapon():
	
	if(currentRangedWeapon.ReadyToShoot()):
		var bullet = currentRangedWeapon.Shoot(get_global_mouse_position())
		get_parent().add_child(bullet)
		bullet.connect("hit_enemy",self,"IncrementDash")

func Streak(start):
	dashCount = 0
	get_parent().add_child(currentMeleeWeapon.GetDashStreak(start,global_position,globalMousePos))
	emit_signal("dash_updated",0)

func CanDash():
	if(dashCount>=dashMax):
		return true
	return false

func IncrementDash(amount):
	if(dashCount<dashMax):
		dashCount+=amount
		emit_signal("dash_updated",float(dashCount)/float(dashMax))


class Sorter:
	# Used to sort body parts based on index
	static func SortParts(a, b):
		if a[1] < b[1]:
			return true
		return false

func UpdateBodyAnimation():
	globalMousePos = get_global_mouse_position()
	relativeMousePosition = globalMousePos-self.global_position
	if(relativeMousePosition.x<0):
		quadrantIndex = 1
	else:
		quadrantIndex = 0
	if(relativeMousePosition.y<0):
		quadrantIndex += 2
	# Quadrant has changed, update body animation and melee weapon sprite
	if($AnimationPlayer.current_animation!=bodyAnimations[quadrantIndex]):
		$AnimationPlayer.play(bodyAnimations[quadrantIndex])
		currentMeleeWeapon.UpdatePosition(quadrantIndex)
		var bodyParts = [[$Parts/Body,0]]
		var handIndex = 2
		if(quadrantIndex>1):
			# Move hands behind player
			handIndex = -2
		bodyParts.append([$Parts/HandL,handIndex])
		bodyParts.append([$Parts/HandR,handIndex])
		bodyParts.append([$"Parts/Melee Weapons",handIndex + currentMeleeWeapon.GetIndex(quadrantIndex)])
		bodyParts.append([$"Parts/Ranged Weapons",handIndex + currentRangedWeapon.GetIndex(quadrantIndex)])
		bodyParts.sort_custom(Sorter,"SortParts")
		$"Parts/Melee Weapons".get_index()
		for i in range(bodyParts.size()):
			if(bodyParts[i][0].get_index()!=i):
				$Parts.move_child(bodyParts[i][0],i)
