# Idle.gd
extends State

onready var legsAnimationPlayer = owner.get_node("LegsAnimationPlayer")

# Upon entering the state, we play the idle animation for the legs
# and set the player's velocity to zero
func Enter(_msg := {}) -> void:
	legsAnimationPlayer.play("Idle")
	owner.velocity = Vector2.ZERO

func Update(_delta: float) -> void:
	# Attacks
	if Input.is_action_pressed("shoot"):
		owner.ShootWeapon()
	if Input.is_action_just_pressed("dash"):
		if(owner.CanDash()):
			stateMachine.TransitionTo("Dash")
	
	# Change weapons
	if Input.is_action_just_pressed("change_melee"):
		owner.ChangeMeleeWeapon()
	if Input.is_action_just_pressed("change_ranged"):
		owner.ChangeRangedWeapon()
	if Input.is_action_pressed("reload"):
		owner.ReloadWeapon()
	
	# If movement input is given transition to walking state
	if (Input.is_action_pressed("move_up") or
		Input.is_action_pressed("move_down") or
		Input.is_action_pressed("move_left") or
		Input.is_action_pressed("move_right")):
		stateMachine.TransitionTo("Walk")
