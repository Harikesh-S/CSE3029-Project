extends CanvasLayer

# Reference to player 
export var playerPath = NodePath()
onready var player = get_node(playerPath)
# Storing required nodes to avoid calling getnode
onready var heartAnimation = $Health/Heart/AnimationPlayer
onready var healthBar = $Health/HealthBar

var currentWeaponUI

onready var dashParticles = $Dash/Particles2D
onready var dashProgress = $Dash/TextureProgress
onready var dashTween = $Dash/Tween

func _ready():
	
	# Initial updates
	UpdateHealth(float(player.health/player.maxHealth))
	ChangeDash(player.currentMeleeWeapon.GetColor())
	UpdateDash(float(player.dashCount/player.maxDash))
	ChangeWeapon(player.currentRangedWeapon.GetUI())
	UpdateWeapon()
	# Connect signals
	player.connect("health_updated",self,"UpdateHealth")
	player.connect("dash_updated",self,"UpdateDash")
	player.connect("dash_changed",self,"ChangeDash")
	player.connect("weapon_updated",self,"UpdateWeapon")
	player.connect("weapon_changed",self,"ChangeWeapon")

func UpdateHealth(ratio):
	heartAnimation.play("default")
	healthBar.UpdateValue(ratio)

func ChangeDash(color):
	dashParticles.process_material.set("color",color)
	dashProgress.tint_progress = color	

func UpdateDash(ratio):
	dashParticles.emitting = bool(ratio>=1)
	dashTween.remove_all()
	dashTween.interpolate_property(dashProgress,"value",null,int(ratio*100),0.5,Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
	dashTween.start()

func ChangeWeapon(weaponUI):
	for child in $Weapons.get_children():
		if(child.name==weaponUI):
			child.show()
			currentWeaponUI = child
		else:
			child.hide()
	currentWeaponUI.Start(player.currentRangedWeapon)

func UpdateWeapon():
	currentWeaponUI.Update()
