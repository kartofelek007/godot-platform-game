extends Area2D

func _on_body_entered(body):
	GameData.playerData["diamonds"] += 1;
	Events.pickup_diamond.emit()	
	queue_free()
