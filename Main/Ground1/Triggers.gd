extends Node2D

func _ready():
	$"../Doors/Door4/CollisionShape2D".set_deferred("disabled",true)

func _on_Tutorial_1_area_entered(area):
	print("Tutorial 1")
	$"Tutorial 1/CollisionShape2D".set_deferred("disabled",true)


func _on_Tutorial_2_area_entered(area):
	print("Tutorial 2")
	$"Tutorial 2/CollisionShape2D".set_deferred("disabled",true)


func _on_Tutorial_3_area_entered(area):
	print("Tutorial 3")
	$"Tutorial 3/CollisionShape2D".set_deferred("disabled",true)


func _on_Tutorial_4_area_entered(area):
	print("Tutorial 4")
	$"Tutorial 4/CollisionShape2D".set_deferred("disabled",true)


func _on_Tutorial_5_area_entered(area):
	print("Tutorial 5")
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
