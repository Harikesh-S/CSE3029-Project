extends Bullet

# Damage type : violet
const DAMAGE_TYPE = 3
# Damage gets multiplied by 1/current scale^2
const DAMAGE = 80
# This weapon cannot crit
const SPEED = 250
# Dash recharge is multiplied by 1/current scale^2
const DASH_RECHARGE = 6

func _ready():
	$AnimationPlayer.play("waveGunBullet")

func Hit() -> void:
	$AnimationPlayer.stop()
	$ImpactParticles.scale = Vector2.ONE/self.scale
	self.set_physics_process(false)
	$Area2D.set_block_signals(true)
	$TrailParticles.emitting = false
	$ImpactParticles.emitting = true
	$Light2D.energy = 0
	$Sprite.play("death")
# warning-ignore:return_value_discarded
	$Sprite.connect("animation_finished",self,"Destroy")

func GetSpeed() -> int:
	return SPEED

func _on_Area2D_area_entered(area):
	var inverseSquare = 1/pow(self.scale.x,2)
	var damage = int(DAMAGE * inverseSquare)
	var recharge = int(DASH_RECHARGE * inverseSquare)
	if(recharge<1):
		recharge = 1
	area.get_parent().OnHit([damage,DAMAGE_TYPE,0,false])
	emit_signal("hit_enemy",recharge)
