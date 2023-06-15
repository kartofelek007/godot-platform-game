extends Path2D

@onready var animation_player = $AnimationPlayer
@export var speed = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.speed_scale = speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
