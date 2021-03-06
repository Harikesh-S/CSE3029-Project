extends Node2D

const ENEMY: PackedScene = preload("res://SpaceLevel/Enemy/Enemy.tscn")

onready var spawnpoints: Node2D = $SpawnPoints

func get_spawn_position()-> Vector2:
	var points = spawnpoints.get_children()
	points.shuffle()
	return points[0].global_position
	
func spawn():
	var spawn_position = get_spawn_position()
	var object = null
	object = ENEMY.instance()
	get_parent().add_child(object)
	object.global_position = spawn_position
	
func _on_Timer_timeout() -> void:
	spawn()
