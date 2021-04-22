extends Enemy

func _ready():
	animationPlayer = $AnimationPlayer
	area2D = $Area2D
	health = 100
	Start()
