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
export var availMeleeWeapons = ["Sword","Greatsword"]
export var meleeWeaponId = 0
export var availRangedWeapons = ["Pistol"]
export var rangedWeaponId = 0
# References to weapons
var meleeWeapons = []
var currentMeleeWeapon
var rangedWeapons = []
var currentRangedWeapon
# Health
export var maxHealth = 100.0
onready var health = maxHealth

# Dash status parameters (dashCount/dashMax %)
var dashMax
var dashCount

func _ready():
	for weapon in availMeleeWeapons:
		meleeWeapons.append(get_node("Parts/Melee Weapons/"+weapon))
	UpdateMeleeWeapon()
	for weapon in availRangedWeapons:
		rangedWeapons.append(get_node("Parts/Ranged Weapons/"+weapon))
	UpdateRangedWeapon()

func UpdateMeleeWeapon():
	currentMeleeWeapon = meleeWeapons[meleeWeaponId]
	dashMax = currentMeleeWeapon.GetDashMax()
	currentMeleeWeapon.show()
	dashCount = 0
	currentMeleeWeapon.dashReady.hide()
	emit_signal("dash_updated",0)

func UpdateRangedWeapon():
	currentRangedWeapon = rangedWeapons[rangedWeaponId]
	currentRangedWeapon.show()

func ChangeMeleeWeapon():
	if !($MeleeSwitchTimer.time_left>0):
		currentMeleeWeapon.hide()
		meleeWeaponId += 1
		meleeWeaponId %= availMeleeWeapons.size()
		UpdateMeleeWeapon()
		# Force update the ordering of parts as melee weapons have different z ordering
		UpdateBodyAnimation()

func _process(delta):
	# Update body and melee animation 
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
		UpdateBodyAnimation()
	# Track mouse cursor - Update the current weapon to aim towards the cursor
	currentRangedWeapon.UpdatePosition(globalMousePos)

func _physics_process(delta):
	move_and_slide(velocity)

func ShootWeapon():
	if(currentRangedWeapon.ReadyToShoot()):
		var bullet = currentRangedWeapon.Shoot(get_global_mouse_position())
		get_parent().add_child(bullet)
		bullet.connect("hit_enemy",self,"IncrementDash")
		self.OnHit(10)

func Streak(start):
	dashCount = 0
	get_parent().add_child(currentMeleeWeapon.GetDashStreak(start,global_position,globalMousePos))
	currentMeleeWeapon.dashReady.hide()
	emit_signal("dash_updated",0)

func CanDash():
	if(dashCount>=dashMax):
		return true
	return false

func IncrementDash(amount):
	if(dashCount<dashMax):
		dashCount+=amount
		emit_signal("dash_updated",float(dashCount)/float(dashMax))
		if(dashCount>=dashMax):
			currentMeleeWeapon.dashReady.show()

func OnHit(amount):
	health -= amount
	emit_signal("health_updated",(health/maxHealth))

class Sorter:
	# Used to sort body parts based on index
	static func SortParts(a, b):
		if a[1] < b[1]:
			return true
		return false

func UpdateBodyAnimation():
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
