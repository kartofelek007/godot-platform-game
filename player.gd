extends CharacterBody2D

class_name Player

@export var SPEED = 100.0
@export var ACCELERATION = 1000.0
@export var FRICTION = 1000.0
@export var JUMP_VELOCITY = -250.0
@export var AIR_RESISTANCE = 200.0
@export var AIR_ACCELERATION = 500.0
@export var GRAVITY_SCALE = 0.8

var air_jump = false
var just_wall_jumped = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var was_wall_normal = Vector2.ZERO
var coyote_jump_started = false

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var respawn_position = global_position
@onready var wall_jump_timer = $WallJumpTimer
@onready var stomp_cpu_particles_2d = $StompCPUParticles2D
@onready var jump_wall_cpu_particles_2d = $JumpWallCPUParticles2D

func _physics_process(delta):
	apply_gravity(delta)
	
	if GameData.playerData["wall_jump"]:
		handle_wall_jump()
	
	if Input.is_action_just_pressed("down"):
		position.y += 1		
		
	handle_jump()
	var input_axis = Input.get_axis("left", "right")
	handle_acceleration(input_axis, delta)
	handle_air_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	apply_air_resistance(input_axis, delta)
	var was_on_floor = is_on_floor()
	var was_on_wall = is_on_wall_only()
	if was_on_wall:
		was_wall_normal = get_wall_normal()
	move_and_slide()
	
	if GameData.playerData["wall_jump"]:
		var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
		if just_left_ledge:
			coyote_jump_timer.start()
			coyote_jump_started = true
		just_wall_jumped = false
		var just_left_wall = was_on_wall and not is_on_wall()
		if just_left_wall:
			wall_jump_timer.start()				
	update_animations(input_axis)

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * GRAVITY_SCALE * delta

func handle_wall_jump():
	if not is_on_wall_only() and wall_jump_timer.time_left <= 0.0: return
	var wall_normal = get_wall_normal()
	
	if wall_jump_timer.time_left > 0.0:
		wall_normal = was_wall_normal
		print("hhh")
		jump_wall_cpu_particles_2d.emitting = true 

	if Input.is_action_just_pressed("jump"):
		velocity.x = wall_normal.x * SPEED
		velocity.y = JUMP_VELOCITY
		just_wall_jumped = true

func handle_jump():
	if GameData.playerData["double_jump"]:
		if is_on_floor(): air_jump = true
	
	if is_on_floor() or (coyote_jump_timer.time_left > 0.0 and coyote_jump_started):
		if Input.is_action_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			coyote_jump_started = false			
			
	elif not is_on_floor():
		if Input.is_action_just_released("jump") and velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2
		
		if GameData.playerData["double_jump"]:
			if Input.is_action_just_pressed("jump") and air_jump and not just_wall_jumped:
				velocity.y = JUMP_VELOCITY * 0.8
				air_jump = false

func handle_acceleration(input_axis, delta):
	if not is_on_floor(): 
		stomp_cpu_particles_2d.emitting = false
		return
		
	if input_axis != 0:		
		velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)
		stomp_cpu_particles_2d.emitting = true
	else: 
		stomp_cpu_particles_2d.emitting = false

func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, SPEED * input_axis, AIR_ACCELERATION * delta)

func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

func apply_air_resistance(input_axis, delta):
	if input_axis == 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, AIR_RESISTANCE * delta)

func update_animations(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
	
	if not is_on_floor():
		animated_sprite_2d.play("jump")

func _on_hazard_detector_area_entered(area):
	global_position = respawn_position


func _on_checkpoin_detector_area_entered(area):
	if !area.activated:
		respawn_position = area.global_position
		area.checkpoint_activated()
