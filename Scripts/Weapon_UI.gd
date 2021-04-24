# Class for weapon UI
class_name Weapon_UI
extends Control


var reloading = false
var weapon = null
var weaponReloadTime = 1.0

# Variables used in updating display
var cTimeRatio
var cAmmo

onready var reloadProgress = $ReloadProgress
onready var instantReload = $InstantReloadParticles

# Virtual function to update display
func UpdateDisplay() -> void:
	pass

# Function to set weapon reference
func Start(weaponRef) -> void:
	weapon = weaponRef
	weaponReloadTime = float(weapon.reloadTimer.wait_time)

# Update call used by GUI
func Update() -> void:
	UpdateDisplay()
	if(weapon.reloadTimer.time_left!=0):
		reloading = true

# Instant reload call used by GUI
func InstantReload() -> void:
	instantReload.emitting = true

# Continous updates
func _process(_delta) -> void:
	if(reloading):
		# Get time left
		cTimeRatio =  100-100*weapon.reloadTimer.time_left/weaponReloadTime
		reloadProgress.show()
		reloadProgress.value = cTimeRatio
		UpdateDisplay()
		if(weapon.reloadTimer.time_left == 0) :
			reloadProgress.hide()
			UpdateDisplay()
			reloading = false
