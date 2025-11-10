extends Area2D

@export var speed = 40.0
var path_follow = PathFollow2D
var direction = 1
var last_position = Vector2.ZERO

func _ready():
	position = Vector2(0, 0)
	path_follow = get_parent()
	if path_follow:
		path_follow.loop = false
	
	rotation = 0.0
	last_position = global_position

func _physics_process(delta):
	if path_follow:
		path_follow.progress += speed * direction * delta

		if path_follow.progress_ratio >= 1.0:
			direction = -1
		elif path_follow.progress_ratio <= 0.0:
			direction = 1

		rotation = 0.0

		var movement = global_position - last_position
		if movement.length() > 0.1:
			$AnimatedSprite2D.flip_h = movement.x < 0

		last_position = global_position