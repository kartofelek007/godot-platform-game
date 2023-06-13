extends Area2D

func _on_body_entered(body):
	print("Wall jump dodany")
	body.wall_jump_aquire = true
	queue_free()
