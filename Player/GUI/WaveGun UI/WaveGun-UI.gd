extends Weapon_UI

# References to anmation players of each indicator + current state
var ammoSprites = []
var ammoStates = []

func _ready():
	for i in range(1,4):
		ammoStates.append(false)
		ammoSprites.append(get_node("Ammo/Ammo"+str(i)+"/AnimationPlayer"))

func UpdateDisplay():
	# Get data from weapon
	cAmmo = weapon.ammo
	# Display
	for i in range(3):
		if cAmmo>i:
			if ammoStates[i]==false:
				ammoSprites[i].play("reload")
				ammoStates[i]=true
		else:
			if ammoStates[i]==true:
				ammoSprites[i].play("use")
				ammoStates[i]=false

