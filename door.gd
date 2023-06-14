extends Area2D

var over_player = false

func _on_body_entered(body):	
	over_player = true	

func _on_body_exited(body):
	over_player = false

func _input(event):
	if over_player and event.is_action_pressed("ui_up"):
		Events.level_completed.emit()
