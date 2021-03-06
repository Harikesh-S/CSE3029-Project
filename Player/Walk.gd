# Walk.gd
extends State

export var SPEED = 200
onready var legsAnimationPlayer = owner.get_node("LegsAnimationPlayer")

# Upon entering the state, we set the Player's leg animation to walk.
func Enter(_msg := {}) -> void:
	legsAnimationPlayer.play("Walk")

# On each update if there is a net input update the player veolcity
# If there is no net input, 
func Update(_delta: float) -> void:
	# Attack
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
	
	# Movement
	owner.velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		owner.velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		owner.velocity.y += 1
	if Input.is_action_pressed("move_left"):
		owner.velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		owner.velocity.x += 1
	if(owner.velocity == Vector2.ZERO):
		stateMachine.TransitionTo("Idle")
	else:
		owner.velocity = owner.velocity.normalized()*SPEED
