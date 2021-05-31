extends Area2D

const HIT_EFFECT: PackedScene = preload("res://SpaceLevel/Hit/HitEffect.tscn")
export(float) var SPEED = 300.0

func kill()->void:
	create_hit_effect()
	queue_free()

func create_hit_effect():
	var main = get_tree().current_scene
	var hitEffect = HIT_EFFECT.instance()
	main.add_child(hitEffect)
	hitEffect.global_position = global_position

func _process(delta: float) -> void:
	position.x += SPEED * delta

func _on_Shoot_area_entered(area: Area2D) -> void:
	area.OnHit([50, 1, false, false])
	kill()
	pass # Replace with function body.

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
