extends Area2D

@onready var flag_on = $FlagOn
@onready var flag_off = $FlagOff
@onready var point_light_2d = $PointLight2D

var activated = false

func checkpoint_activated():
	if !activated:
		flag_off.play("default")
		activated = true				
		
func _on_flag_off_animation_finished():
	flag_off.hide()
	flag_on.show()
