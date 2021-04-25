extends KinematicBody2D

# signals
signal health_updated(healthRatio)
signal dash_updated(dashRatio)
signal dash_changed(color)
signal weapon_updated()
# warning-ignore:unused_signal
signal weapon_changed(weaponUIName)
signal weapon_instant_reload()

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
export var availRangedWeapons = ["Pistol","WaveGun"]
export var rangedWeaponId = 0
# References to weapons
var meleeWeapons = []
var currentMeleeWeapon
var rangedWeapons = []
var currentRangedWeapon
# Health and defenses
export var maxHealth = 100.0
onready var health = maxHealth
export var def = [0.1,0.1,0.1,0.1]
# Floating text for health changes
var floatingTextRes = preload("res://Scenes/FloatingText.tscn")

# Dash status parameters (dashCount/MaxDash %)
var maxDash
var dashCount

func _ready():
	for weapon in availMeleeWeapons:
		meleeWeapons.append(get_node("Parts/Melee Weapons/"+weapon))
	UpdateMeleeWeapon()
	for weapon in availRangedWeapons:
		rangedWeapons.append(get_node("Parts/Ranged Weapons/"+weapon))
	UpdateRangedWeapon()

func _physics_process(_delta):
# warning-ignore:return_value_discarded
	move_and_slide(velocity)

func _process(_delta):
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
	# If current weapon has no ammo, try to reload
	if currentRangedWeapon.ammo == 0:
		ReloadWeapon()

func UpdateMeleeWeapon():
	currentMeleeWeapon = meleeWeapons[meleeWeaponId]
	maxDash = currentMeleeWeapon.GetMaxDash()
	currentMeleeWeapon.show()
	dashCount = 0
	currentMeleeWeapon.DashReadyEffect(false)
	emit_signal("dash_changed",currentMeleeWeapon.GetColor())
	emit_signal("dash_updated",0)

func UpdateRangedWeapon():
	currentRangedWeapon = rangedWeapons[rangedWeaponId]
	currentRangedWeapon.show()
	emit_signal("weapon_changed",currentRangedWeapon.GetUI())

func ChangeMeleeWeapon():
	if !($MeleeSwitchTimer.time_left>0):
		currentMeleeWeapon.hide()
		meleeWeaponId += 1
		meleeWeaponId %= availMeleeWeapons.size()
		UpdateMeleeWeapon()
		# Force update the ordering of parts as melee weapons have different z ordering
		UpdateBodyAnimation()

func ChangeRangedWeapon():
	if !($RangedSwitchTimer.time_left>0):
		currentRangedWeapon.hide()
		currentRangedWeapon.CancelReload()
		rangedWeaponId += 1
		rangedWeaponId %= availRangedWeapons.size()
		UpdateRangedWeapon()
		# Force update the ordering of parts as weapons have different z ordering
		UpdateBodyAnimation()

func InstantReload():
	currentRangedWeapon.InstantReload()
	emit_signal("weapon_updated")
	emit_signal("weapon_instant_reload")

func ReloadWeapon():
	currentRangedWeapon.Reload()
	emit_signal("weapon_updated")

func ShootWeapon():
	if(currentRangedWeapon.ReadyToShoot()):
		currentRangedWeapon.CancelReload()
		var bullet = currentRangedWeapon.Shoot(get_global_mouse_position())
		get_parent().add_child(bullet)
		bullet.connect("hit_enemy",self,"IncrementDash")
		emit_signal("weapon_updated")

func Streak(start):
	currentRangedWeapon.CancelReload()
	emit_signal("weapon_updated")
	dashCount = 0
	get_parent().add_child(currentMeleeWeapon.GetDashStreak(start,global_position))
	currentMeleeWeapon.DashReadyEffect(false)
	emit_signal("dash_updated",0)

func CanDash():
	if(dashCount>=maxDash):
		return true
	return false

func IncrementDash(amount):
	if(dashCount<maxDash):
		dashCount+=amount
		emit_signal("dash_updated",float(dashCount)/float(maxDash))
		if(dashCount>=maxDash):
			currentMeleeWeapon.DashReadyEffect(true)

func OnHit(damage):
	# Damage calculation 
	var amount = int(damage[0]*(1-def[damage[1]]))
	
	var floatingText = floatingTextRes.instance()
	floatingText.amount = amount
	floatingText.type = damage[1] # Type
	floatingText.crit = damage[2] # Crit
	add_child(floatingText)
	
	health -= amount
	if(health<0):
		health = 0
	emit_signal("health_updated",(health/maxHealth))
	
func OnHeal(amount):
	var floatingText = floatingTextRes.instance()
	floatingText.amount = amount
	floatingText.type = 4
	add_child(floatingText)
	health += amount
	if(health>maxHealth):
		health=maxHealth
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
	for i in range(bodyParts.size()):
		if(bodyParts[i][0].get_index()!=i):
			$Parts.move_child(bodyParts[i][0],i)
