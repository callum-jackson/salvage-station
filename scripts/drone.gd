extends Area2D

@export var speed = 40.0
@export var loop_path = false
var path_follow = PathFollow2D
var direction = 1

func _ready():
	position = Vector2(0, 0)
	path_follow = get_parent()
	if path_follow and path_follow is PathFollow2D:
		path_follow.loop = loop_path

func _physics_process(delta):
	if path_follow and path_follow is PathFollow2D:
		if loop_path:
			path_follow.progress += speed * delta
		else:
			path_follow.progress += speed * direction * delta
			if path_follow.progress_ratio >= 1.0:
				direction = -1
			elif path_follow.progress_ratio <= 0.0:
				direction = 1

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		game_manager.died()
