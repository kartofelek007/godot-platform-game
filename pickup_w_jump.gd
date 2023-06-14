extends Area2D

func _on_body_entered(body):
	print("Wall jump dodany")	
	GameData.playerData["wall_jump"] = true
	queue_free()
