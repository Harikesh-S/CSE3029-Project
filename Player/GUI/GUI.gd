extends CanvasLayer

# Reference to player 
export var playerPath = NodePath()
onready var player = get_node(playerPath)
# Storing required nodes to avoid calling getnode
onready var heartAnimation = $Health/Heart/AnimationPlayer
onready var dashIcon = $Dash/Icon
onready var dashParticles = $Dash/Particles2D
onready var dashProgress = $Dash/TextureProgress
onready var dashTween = $Dash/Tween

func _ready():
	
	# Initial updates
	UpdateHealth(1)
	UpdateDash(float(player.dashCount/player.dashMax))
	
	# Connect signals
	player.connect("health_updated",self,"UpdateHealth")
	player.connect("dash_updated",self,"UpdateDash")

func UpdateHealth(ratio):
	heartAnimation.play("default")

func UpdateDash(ratio):
	var color : Color = player.currentMeleeWeapon.GetColor()
	dashIcon.modulate = color
	dashParticles.process_material.set("color",color)
	dashParticles.emitting = bool(ratio>=1)
	dashTween.remove_all()
	dashTween.interpolate_property(dashProgress,"value",null,int(ratio*100),0.5,Tween.TRANS_SINE,Tween.EASE_OUT)
	dashTween.start()
