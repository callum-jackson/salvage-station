extends Area2D

@export var rotation_speed = 120.0

var raycast: RayCast2D
var raycast_reverse: RayCast2D
var line: Line2D
var line_reverse: Line2D
var collision_shape_node: CollisionShape2D
var collision_shape_node_reverse: CollisionShape2D

func _ready() -> void:
	line = $Line2D
	line_reverse = $Line2DReverse
	raycast = $RayCast2D
	raycast_reverse = $RayCast2DReverse
	collision_shape_node = $CollisionShape2D
	collision_shape_node_reverse = $CollisionShape2DReverse
	
	raycast.enabled = true
	raycast.target_position = Vector2(200, 0)
	raycast_reverse.enabled = true
	raycast_reverse.target_position = Vector2(-200, 0)

func _physics_process(delta: float) -> void:
	rotation_degrees += rotation_speed * delta
	if rotation_degrees >= 360:
		rotation_degrees -= 360
	
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
	
	var distance_reverse = 200.0
	if raycast_reverse.is_colliding():
		var collision_point = raycast_reverse.get_collision_point()
		var origin = global_position
		distance_reverse = origin.distance_to(collision_point)
	
	line_reverse.points = [Vector2(0, 0), Vector2(-distance_reverse, 0)]
	
	if collision_shape_node_reverse and collision_shape_node_reverse.shape:
		collision_shape_node_reverse.shape.size = Vector2(distance_reverse, 2)
		collision_shape_node_reverse.position = Vector2(-distance_reverse / 2.0, 0)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		game_manager.died()