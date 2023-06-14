extends Area2D

func _on_body_entered(body):
	print("Double jump dodany")
	GameData.playerData["double_jump"] = true
	queue_free()
