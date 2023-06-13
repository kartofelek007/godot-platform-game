extends Area2D

func _on_body_entered(body):
	print("Double jump dodany")
	body.double_jump_aquire = true
	queue_free()
