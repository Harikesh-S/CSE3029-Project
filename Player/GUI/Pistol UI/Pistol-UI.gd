extends Control

var reloading = false
var weapon = null
var weaponReloadTime = 1.0

# Variables used in updating display
var cTimeRatio
var cAmmo
# References to anmation players of each indicator + current state
var ammoSprites = []
var ammoStates = []

onready var reloadProgress = $ReloadProgress
onready var instantReload = $InstantReloadParticles

func _ready():
	for i in range(1,7):
		ammoStates.append(false)
		ammoSprites.append(get_node("Ammo/Ammo"+str(i)+"/AnimationPlayer"))

func UpdateDisplay():
	# Get data from weapon
	cAmmo = weapon.ammo
	# Display
	for i in range(6):
		if cAmmo>i:
			if ammoStates[i]==false:
				ammoSprites[i].play("reload")
				ammoStates[i]=true
		else:
			if ammoStates[i]==true:
				ammoSprites[i].play("use")
				ammoStates[i]=false

# Function to set weapon reference
func Start(weaponRef):
	weapon = weaponRef
	weaponReloadTime = float(weapon.reloadTimer.wait_time)

# Update call used by GUI
func Update():
	UpdateDisplay()
	if(weapon.reloadTimer.time_left!=0):
		reloading = true

# Instant reload call used by GUI
func InstantReload():
	instantReload.emitting = true

# Continous updates
func _process(delta):
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
