extends Node

var playerData = {
	"double_jump" : false,
	"wall_jump" : false,
	"diamonds" : 0,
	"key" : false
}

var debugMode = false

func _input(event):
	if event.is_action_pressed("debug"):
		debugMode = true
		playerData["double_jump"] = true
		playerData["wall_jump"] = true
		playerData["key"] = true
		Events.pickup_double_jump.emit() #dowolny z eventow bo chce aktualizoawac ui

func reset_player_data():
	playerData["double_jump"] = false
	playerData["wall_jump"] = false
	playerData["diamonds"] = 0
