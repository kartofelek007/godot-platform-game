extends MarginContainer

@onready var start_game_button = %StartGameButton
@onready var quit_button = %QuitButton

func _ready():
	GameData.reset_player_data()
	start_game_button.grab_focus()

func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://level_1.tscn")

func _on_quit_button_pressed():
	get_tree().quit()



