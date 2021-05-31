extends Enemy

const SPEED = 100

# Using squared distance to save time when finding distance
var minDistSq = 0
var playerDistSq
var active = false
var pathDistSq

var path = []

onready var player = get_node("../../Player")
onready var nav = get_node("../../../Nav")

func _ready():
	maxHealth = 1.0
	def = [0.1,0.1,0.1,0.1]
	Start()

func _process(_delta):
	# Contact damage
	for area in area2D.get_overlapping_areas():
		var obj = area.get_parent()
		if(obj.is_in_group("Player")):
			obj.OnHit([20,2,false,true])
			# If active move
	if(active):
		# If it needs to move
		# Distance to player
		playerDistSq = player.global_position.distance_squared_to(self.global_position)
		if(playerDistSq>minDistSq):
			path = nav.get_simple_path(self.global_position,player.global_position,false)

func _physics_process(delta):
	if(alive):
		while(path.size()>1):
			pathDistSq = self.global_position.distance_squared_to(path[0])
			#print(path)
			if(pathDistSq>300):
				move_and_slide((path[0]-self.global_position).normalized()*SPEED)
				break
			else:
				path.remove(0)
