# Used by all enemies to call instant reload on player if they were killed 
# by the player's dash

extends YSort

export var playerPath = NodePath("../Player")
onready var player = get_node(playerPath)

func DashKill():
	player.InstantReload()
