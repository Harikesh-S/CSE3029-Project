extends DashStreak

func AreaEntered(area : Area2D) -> void:
	area.get_parent().OnEffect("ShatterDef")
	area.get_parent().OnHit([100,2,1,true])
