extends CharacterBody2D

@export var speed = 50
@export var dash_speed = 125
@export var dash_duration = 0.3

var screen_size
var current_speed
var is_dashing = false
var dash_timer = 0.0
var cooldown_timer = 0.0

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	if cooldown_timer > 0:
		cooldown_timer -= delta
		if cooldown_timer <= 0:
			game_state.dash_available = true
	
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
	
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if Input.is_action_just_pressed("dash"):
		if game_state.has_thrusters and game_state.dash_available and velocity.length() > 0:
			is_dashing = true
			dash_timer = dash_duration
			game_state.dash_available = false
			cooldown_timer = game_state.dash_cooldown_time
	
	if velocity.length() > 0 or is_dashing:
		if is_dashing:
			current_speed = dash_speed
			$AnimatedSprite2D.animation = "dash"
		else:
			current_speed = speed
			if game_state.has_thrusters:
				$AnimatedSprite2D.animation = "run_thrusters"
			else:
				$AnimatedSprite2D.animation = "run"
		velocity = velocity.normalized() * current_speed
		$AnimatedSprite2D.play()
	else:
		if game_state.has_thrusters:
			$AnimatedSprite2D.animation = "idle_thrusters"
		else:
			$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.play()
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	move_and_slide()