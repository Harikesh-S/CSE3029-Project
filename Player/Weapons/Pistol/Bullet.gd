extends Bullet

# Damage type
const DAMAGE_TYPE = 0
const DAMAGE = [10,15] # Damage range
const CRIT_DAMAGE = 2 # Multiplier
const CRIT_RATE = 0.25 # Out of 1
const SPEED = 800
const DASH_RECHARGE = 2

func Hit() -> void:
	self.set_physics_process(false)
	$Area2D.set_block_signals(true)
	$TrailParticles.emitting = false
	$ImpactParticles.emitting = true
	$Light2D.energy *= 1.25
	$Sprite.play("death")
# warning-ignore:return_value_discarded
	$Sprite.connect("animation_finished",self,"Destroy")

func GetSpeed() -> int:
	return SPEED

func _on_Area2D_area_entered(area):
	# Calculate random damage number from range
	var damage = rand_range(DAMAGE[0],DAMAGE[1])
	if(rand_range(0, 1)<CRIT_RATE):
		# Multiply by crit damage if crit
		damage *= CRIT_DAMAGE
		area.get_parent().OnHit([damage,DAMAGE_TYPE,1,false])
	else:
		area.get_parent().OnHit([damage,DAMAGE_TYPE,0,false])
	emit_signal("hit_enemy",DASH_RECHARGE)
	
	Hit()
