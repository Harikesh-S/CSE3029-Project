extends Node2D

var tutorials = [
	preload("res://Scenes/Tutorials/G1-T1.tscn"),
	preload("res://Scenes/Tutorials/G1-T2.tscn"),
	preload("res://Scenes/Tutorials/G1-T3.tscn"),
	preload("res://Scenes/Tutorials/G1-T4.tscn"),
	preload("res://Scenes/Tutorials/G1-T5.tscn"),
]


func _ready():
	$"../Doors/Door4/CollisionShape2D".set_deferred("disabled",true)

func _on_Tutorial_1_timeout():
	if(get_node("../../../").tutorials):
		print("Tutorial 1")
		var tutorial = tutorials[0].instance()
		get_node("../Tutorials").add_child(tutorial)
		get_tree().paused = true


func _on_Tutorial_2_area_entered(area):
	if(get_node("../../../").tutorials):
		print("Tutorial 2")
		var tutorial = tutorials[1].instance()
		get_node("../Tutorials").add_child(tutorial)
		get_tree().paused = true
		$"Tutorial 2/CollisionShape2D".set_deferred("disabled",true)


func _on_Tutorial_3_area_entered(area):
	if(get_node("../../../").tutorials):
		print("Tutorial 3")
		var tutorial = tutorials[2].instance()
		get_node("../Tutorials").add_child(tutorial)
		get_tree().paused = true
		$"Tutorial 3/CollisionShape2D".set_deferred("disabled",true)


func _on_Tutorial_4_area_entered(area):
	if(get_node("../../../").tutorials):
		print("Tutorial 4")
		var tutorial = tutorials[3].instance()
		get_node("../Tutorials").add_child(tutorial)
		get_tree().paused = true
		$"Tutorial 4/CollisionShape2D".set_deferred("disabled",true)


func _on_Tutorial_5_area_entered(area):
	if(get_node("../../../").tutorials):
		print("Tutorial 5")
		var tutorial = tutorials[4].instance()
		get_node("../Tutorials").add_child(tutorial)
		get_tree().paused = true
		$"Tutorial 5/CollisionShape2D".set_deferred("disabled",true)

onready var enemies = get_node("../YSort/Enemies")
func _on_Activate_1_area_entered(area):
	enemies.get_node("Blob").active = true
	enemies.get_node("Blob2").active = true
	$"Activate 1/CollisionShape2D".set_deferred("disabled",true)


func _on_Activate_2_area_entered(area):
	enemies.get_node("Blob3").active = true
	enemies.get_node("Blob4").active = true
	enemies.get_node("Blob5").active = true
	$"Activate 2/CollisionShape2D".set_deferred("disabled",true)


func _on_Activate_3_area_entered(area):
	enemies.get_node("Blob6").active = true
	enemies.get_node("Blob7").active = true
	enemies.get_node("Blob8").active = true
	enemies.get_node("Blob9").active = true
	enemies.get_node("Blob10").active = true
	$"Activate 3/CollisionShape2D".set_deferred("disabled",true)


func _on_Activate_4_area_entered(area):
	enemies.get_node("Boss").active = true
	$"Activate 4/CollisionShape2D".set_deferred("disabled",true)
	
	$"../Doors/Door4".show()
	$"../Doors/Door4/CollisionShape2D".set_deferred("disabled",false)


