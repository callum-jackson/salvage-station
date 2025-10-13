extends CharacterBody2D

@export var speed = 50
@export var dash_speed = 125

var screen_size
var current_speed

func _ready() -> void:
	screen_size = get_viewport_rect().size
	
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		if Input.is_action_pressed("dash"):
			if game_state.has_thrusters:
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
