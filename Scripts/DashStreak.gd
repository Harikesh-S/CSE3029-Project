# Streak created after a melee dash
class_name DashStreak
extends Position2D

var startPos : Vector2
var endPos : Vector2
var time : float

# Destroy the streak after the tween is done
func Destroy():
	queue_free()

# Function to initialize position and rotation and start tween
func _ready():
	# Set starting variables
	self.global_position = startPos
	self.look_at(endPos)
	# Scale streak based on distance
	var area2D = $Area2D
	self.scale.x = startPos.distance_to(endPos)/float(area2D.position.x*2)
	#$Particles2D.emitting = true
	# Tween
	var tween = $Tween
	var color = self.modulate
	color.a = 0
	tween.interpolate_property(self,'modulate',null,color,time,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	tween.interpolate_property($Light2D,'energy',null,0,time,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	tween.start()
	# Connect signals
	tween.connect("tween_all_completed",self,"Destroy")
	area2D.connect("area_entered",self,"AreaEntered")

# Function to affect enemies in the dash area
func AreaEntered(_area : Area2D) -> void:
	pass
