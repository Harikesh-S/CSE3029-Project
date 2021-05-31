# Used by all enemies to call instant reload on player if they were killed 
# by the player's dash

extends YSort

export var playerPath = NodePath("../Player")
onready var player = get_node(playerPath)

var count = 11


func DashKill():
	player.InstantReload()

func Kill(enemyScore):
	count -= 1
	get_node("../../../../").score += enemyScore
	if(count==0):
		# Win
		get_node("../../").Win()
	if(count==1):
		#Open door 3
		$"../../Doors/Door3".queue_free()
	if(count==6):
		#Open door 2
		$"../../Doors/Door2".queue_free()
		pass
	if(count==9):
		#Open door 1
		$"../../Doors/Door".queue_free()
		pass
	
