extends Area2D

@export var speed = 40.0
@export var loop_path = false
var path_follow = PathFollow2D
var direction = 1
var rand_sound_timer = 0.0
var next_rand_sound = 1.0

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
				
	rand_sound_timer += delta
	if rand_sound_timer >= next_rand_sound:
		if randf() > 0.5:
#			$DroneSound01.play()
			pass
		else:
#			$DroneSound02.play()
			pass
		rand_sound_timer = 0.0
		next_rand_sound = randf_range(2.0, 5.0)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		game_manager.died()
