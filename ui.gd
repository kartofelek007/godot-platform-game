extends Control

@onready var label = $MarginContainer/Label
@onready var double_jump = $"Double-jump"
@onready var wall_jump = $"Wall-jump"
@onready var key = $Key

func _ready():
	update_ui()
	Events.pickup_double_jump.connect(update_ui)
	Events.pickup_diamond.connect(update_ui)
	Events.pickup_wall_jump.connect(update_ui)
	Events.pickup_key.connect(update_ui)

func update_ui():
	label.text = str(GameData.playerData["diamonds"])
	if GameData.playerData["double_jump"]:
		double_jump.modulate.a = 100
	if GameData.playerData["wall_jump"]:
		wall_jump.modulate.a = 100
	if GameData.playerData["key"]:
		key.modulate.a = 100	
	
