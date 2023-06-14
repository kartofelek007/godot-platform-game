extends Area2D

func _on_body_entered(body):
	print("Key dodany")
	GameData.playerData["key"] = true
	Events.pickup_key.emit()
	Events.open_door_to_next_level.emit()
	queue_free()
