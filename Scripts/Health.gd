extends Area2D


func _ready():
	pass


func _on_Health_area_entered(area):
	if(area.get_parent().is_in_group("Player")):
		area.get_parent().OnHeal(100)
		self.queue_free()
