extends Node2D

export var damage : bool
export var amount : float
export var type : int
export var crit : int

func _ready():
	if damage == true:
		$Label.text = "Damage "+ str(amount) +",\nType : "+ str(type) + ",\nCrit : "+ str(crit)
	else:
		$Label.text = "Heal "+ str(amount)


func _on_Area2D_area_entered(area):
	if damage:
		area.get_parent().OnHit([amount,type,crit,true])
	else:
		area.get_parent().OnHeal(amount)
