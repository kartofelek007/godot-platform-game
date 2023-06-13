extends Area2D

@onready var flag_iddle = $FlagIddle
@onready var flag_off = $FlagOff

var activated = false

func checkpoint_activated():
	if !activated:
		flag_iddle.hide()
		flag_off.show()
		flag_off.play("default")
		activated = true
