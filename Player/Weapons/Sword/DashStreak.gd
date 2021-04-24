extends DashStreak

func AreaEntered(area : Area2D) -> void:
	area.get_parent().OnHit([50,true,true])
