extends YSort
# Temporary enemy controller
export var playerPath = NodePath("../Player")
onready var player = get_node(playerPath)

func DashKill():
	player.InstantReload()
