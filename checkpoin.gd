extends Area2D

@onready var flag_iddle = $FlagIddle
@onready var flag_off = $FlagOff
@onready var point_light_2d = $PointLight2D

var activated = false

func checkpoint_activated():
	if !activated:
		flag_iddle.hide()
		flag_off.show()		
		flag_off.play("default")
		activated = true		
		var tween = get_tree().create_tween()
		await tween.tween_property(point_light_2d, "energy", 1.5, 0.05).finished
		point_light_2d.hide()
		
func _on_flag_off_animation_finished():
	flag_off.hide()
	flag_iddle.show()
