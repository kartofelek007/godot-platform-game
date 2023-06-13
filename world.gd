extends Node2D

@onready var level_completed = $CanvasLayer/LevelCompleted

@export var next_level : PackedScene

func _ready():
	RenderingServer.set_default_clear_color(Color.html("#000"))
	Events.level_completed.connect(show_level_completed)

func show_level_completed():
	level_completed.show()
	if not next_level is PackedScene: return
	get_tree().paused = true
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)
	LevelTransition.fade_from_black()
	
