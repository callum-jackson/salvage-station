extends Area2D

@export var rotation_speed = 90.0
@export var sweep_angle = 180.0

var raycast: RayCast2D
var line: Line2D
var collision_shape_node: CollisionShape2D
var direction = 1
var initial_rotation = 0.0
var current_angle = 0.0

func _ready() -> void:
	line = $Line2D
	raycast = $RayCast2D
	collision_shape_node = $CollisionShape2D
	
	raycast.enabled = true
	raycast.target_position = Vector2(200, 0)
	
	initial_rotation = rotation_degrees
	current_angle = 0.0

func _physics_process(delta: float) -> void:
	current_angle += rotation_speed * direction * delta
	
	if current_angle >= sweep_angle / 2:
		current_angle = sweep_angle / 2
		direction = -1
	elif current_angle <= -sweep_angle / 2:
		current_angle = -sweep_angle / 2
		direction = 1
	
	rotation_degrees = initial_rotation + current_angle
	
	update_laser_length()

func update_laser_length() -> void:
	var distance = 200.0
	if raycast.is_colliding():
		var collision_point = raycast.get_collision_point()
		var origin = global_position
		distance = origin.distance_to(collision_point)
	
	line.points = [Vector2(0, 0), Vector2(distance, 0)]
	
	if collision_shape_node and collision_shape_node.shape:
		collision_shape_node.shape.size = Vector2(distance, 2)
		collision_shape_node.position = Vector2(distance / 2.0, 0)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().reload_current_scene()