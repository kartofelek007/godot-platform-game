extends Area2D

func _on_body_entered(body):
	print("Double jump dodany")
	GameData.playerData["double_jump"] = true
	Events.pickup_double_jump.emit()
	queue_free()
