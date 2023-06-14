extends Control

@onready var label = $MarginContainer/Label
@onready var double_jump = $"Double-jump"
@onready var wall_jump = $"Wall-jump"


func _process(delta):
	label.text = str(GameData.playerData["diamonds"])
	if GameData.playerData["double_jump"]:
		double_jump.modulate.a = 100
	if GameData.playerData["wall_jump"]:
		wall_jump.modulate.a = 100
