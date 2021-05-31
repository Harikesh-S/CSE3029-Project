extends Area2D

var floatingTextRes = preload("res://Scenes/FloatingText.tscn")
var shoot_something = preload("res://SpaceLevel/Shoot/Shoot1.tscn")

var health : float
var maxHealth : float
var def : Array
var alive : bool = true

onready var animationPlayer = $AnimationPlayer
onready var area2D = $Area2D
onready var healthBar = $HealthBar
onready var effects = $StatusEffects

func Start():
	effects.InitEffectDefaults()
	health = maxHealth
	animationPlayer.play("Idle")
	animationPlayer.connect("animation_finished",self,"AnimationFinished")
	healthBar.UpdateValue(health/maxHealth)

func AnimationFinished(animationName : String):
	if(animationName=="Hit"):
		animationPlayer.play("Idle")
	if(animationName=="Death"):
		queue_free()

func Die():
	effects.visible = false
	animationPlayer.play("Death")
	$Collision.set_deferred("disabled",true)
	get_parent().die_enemy()
	SPEED = 0.0
	alive = false

func OnEffect(effectName) -> void:
	effects.AddEffect(effectName)

func OnHit(damage) -> void:
	# damage = [ value, type, crit?, melee? ]
	if !alive:
		return
	# Damage calculation 
	var amount = int(damage[0]*(1-def[damage[1]]))
	var floatingText = floatingTextRes.instance()
	floatingText.amount = amount
	floatingText.type = damage[1] # Type
	floatingText.crit = damage[2] # Crit
	add_child(floatingText)
	self.health -= amount
	animationPlayer.play("Hit")
	healthBar.UpdateValue(health/maxHealth)
	if(health <= 0):
		Die()
		if damage[3] == true: # Was killed by a melee attack, send signal
			get_parent().DashKill()

#const EXPLOSION_FX: PackedScene = preload("res://SpaceLevel/Explosion/Explosion.tscn")

export(float) var SPEED = 250.0

func _ready() -> void:
	maxHealth = 100.0
	def = [0.1, 0.5, 0.1, 0.1]
	add_to_group("enemies")
	Start()

func _process(delta: float) -> void:
	position.x -= SPEED * delta

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
	
#func kill() -> void:
#	var main = get_tree().current_scene
#	var explosion_fx = EXPLOSION_FX.instance()
#	main.add_child(explosion_fx)
#	explosion_fx.global_position = global_position
#	queue_free()
	
#func _on_Enemy_body_entered(body: Node) -> void:
#	body.kill()
#	kill()

func _on_Timer_timeout() -> void:
	if(alive):
		var shoot = shoot_something.instance()
		shoot.SPEED = -300
		shoot.global_position = $Position2D.global_position
		get_parent().add_child(shoot)
		$Timer.start()
