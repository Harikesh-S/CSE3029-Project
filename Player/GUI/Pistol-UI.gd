extends Control

var reloading = false
var weapon = null
var weaponReloadTime = 1.0

# Variables used in updating display
var cTimeRatio
var cAmmo

func UpdateDisplay():
	# Get data from weapon
	cTimeRatio =  float(weapon.reloadTimer.time_left)/weaponReloadTime
	cAmmo = weapon.ammo
	# Display
	$Label.text = str(cAmmo)
	$Label2.text = str(cTimeRatio)

# Function to set weapon reference
func Start(weaponRef):
	weapon = weaponRef
	weaponReloadTime = float(weapon.reloadTimer.wait_time)

# Update call
func Update():
	UpdateDisplay()
	if(weapon.reloadTimer.time_left!=0):
		reloading = true

# Continous updates
func _process(delta):
	if(reloading):
		UpdateDisplay()
		if(weapon.reloadTimer.time_left == 0) :
			UpdateDisplay()
			reloading = false
