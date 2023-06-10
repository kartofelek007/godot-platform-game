extends CharacterBody2D


@export var SPEED = 100.0
@export var ACCELERATION = 1000.0
@export var FRICTION = 1000.0
@export var JUMP_VELOCITY = -250.0
@export var AIR_RESISTANS = 200.0
@export var AIR_ACCELERATION = 500.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var air_jump = false
var was_wall_jumped = false

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var starting_position = global_position
@onready var coyote_jump_timer = $CoyoteJumpTimer


func _physics_process(delta):
	apply_gravity(delta)	
	handle_wall_jump()
	handle_jump()

	var input_axis = Input.get_axis("ui_left", "ui_right")
	handle_acceleration(input_axis, delta)
	handle_air_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	update_animation(input_axis)
	
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_jump_timer.start()
	was_wall_jumped = false	

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
func handle_wall_jump():
	if not is_on_wall_only(): return
	var	wall_normal = get_wall_normal()
	if Input.is_action_just_pressed("ui_up"):
		velocity.x = wall_normal.x * (SPEED * 1.5)
		velocity.y = JUMP_VELOCITY	
		was_wall_jumped = true
	
		
func handle_jump():
	if is_on_floor(): air_jump = true
	
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_VELOCITY
			
	if not is_on_floor():
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2
			
		if Input.is_action_just_pressed("ui_up") and air_jump and not was_wall_jumped:
			velocity.y = JUMP_VELOCITY * 0.8
			air_jump = false			
				
			
func apply_friction(input_axis, delta):
	if input_axis == 0:				
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
			
func handle_acceleration(input_axis, delta):
	if not is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)		

func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, SPEED * input_axis, AIR_ACCELERATION * delta)		

func update_animation(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = input_axis < 0
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
		
	if not is_on_floor():
		animated_sprite_2d.play("jump")

func _on_hazard_detector_area_entered(area):
	print_debug("die")
	global_position = starting_position
