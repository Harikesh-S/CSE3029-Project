# Dash.gd
extends State

onready var legsAnimationPlayer = owner.get_node("LegsAnimationPlayer")
onready var ready = $Ready
onready var recovery = $Recovery

var dash : Vector2 #Used to store dash vector
var start: Vector2 #Used to store starting location

# Upon entering the state, we disable the player's collision, 
# perform the dash based on the current melee weapon, calculate the vector dashed,
# Get midpoint, length and angle of the vector
# Create a dash instance and add it to the player node,
# Enable the player's collision nodes again
func Enter(_msg := {}) -> void:
	legsAnimationPlayer.play("Idle")
	owner.velocity = Vector2.ZERO
	# Remove collision hitboxes for enemies
	owner.set_collision_layer_bit(1,false)
	owner.set_collision_mask_bit(2,false)
	# Start wait timer
	start = owner.global_position
	ready.start(owner.currentMeleeWeapon.dashStartTime)

func _on_Ready_timeout():
	# Dash
	dash = owner.globalMousePos - owner.global_position;
	if(dash.length_squared()>owner.currentMeleeWeapon.GetDashDistanceSquared()):
		dash = dash.normalized()*owner.currentMeleeWeapon.GetDashDistance()
	owner.move_and_collide(dash)
	# Create Streak
	owner.Streak(start)
	# Start recovery timer
	recovery.start(owner.currentMeleeWeapon.dashEndTime)

func _on_Recovery_timeout():
	# Add collision back
	owner.set_collision_layer_bit(1,true)
	owner.set_collision_mask_bit(2,true)
	stateMachine.TransitionTo("Idle")


func Update(delta: float) -> void:
	owner.velocity = Vector2.ZERO