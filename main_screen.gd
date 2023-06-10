extends MarginContainer


func _ready():
	pass

func _input(event):
	if event.is_pressed():
		get_tree().change_scene_to_file("res://main_menu.tscn")

