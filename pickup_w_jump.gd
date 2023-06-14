extends Area2D

func _on_body_entered(body):
	print("Wall jump dodany")	
	GameData.playerData["wall_jump"] = true
	Events.pickup_wall_jump.emit()
	queue_free()
