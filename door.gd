extends Area2D

@onready var sprite_2d_door_open = $Sprite2DDoorOpen
@onready var sprite_2d_door_closed = $Sprite2DDoorClosed

var over_player = false
var is_open = false

func _ready():
	sprite_2d_door_closed.show()
	sprite_2d_door_open.hide()
	Events.open_door_to_next_level.connect(open_door)

func _on_body_entered(body):	
	over_player = true	

func _on_body_exited(body):
	over_player = false

func _input(event):
	if over_player and event.is_action_pressed("ui_up") and is_open:
		Events.level_completed.emit()
		
func open_door():
	sprite_2d_door_closed.hide()
	sprite_2d_door_open.show()
	is_open = true			
