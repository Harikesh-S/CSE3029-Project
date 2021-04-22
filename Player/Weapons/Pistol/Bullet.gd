extends Bullet

const DAMAGE = 10
const DAMAGE_CRIT = 15
const CRIT_RATE = 0.5 # Out of 1
const SPEED = 1000
var active = true

func _ready():
	pass

func hit() -> void:
	active = false
	self.set_physics_process(false)
	$Area2D.set_block_signals(true)
	$TrailParticles.emitting = false
	$ImpactParticles.emitting = true
	$Light2D.energy *= 2
	$Sprite.play("death")
	$Timer.start()
	$Timer.connect("timeout",self,"destroy")

func GetDamage():
	if(active):
		emit_signal("hit_enemy",1)
		hit()
		if(rand_range(0, 1)<CRIT_RATE):
			return [DAMAGE_CRIT,true]
		else:
			return [DAMAGE,false]

func GetSpeed() -> int:
	return SPEED
