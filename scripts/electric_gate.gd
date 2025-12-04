extends Area2D

@export var on_duration = 2.0
@export var off_duration = 2.0
@export var starts_active = true

var is_active = true
var timer = 0.0

func _ready():
	is_active = starts_active
	timer = on_duration if starts_active else off_duration
	update_state()

func _physics_process(delta):
	timer -= delta
	
	if timer <= 0:
		is_active = !is_active
		timer = on_duration if is_active else off_duration
		update_state()

func update_state() -> void:
	if is_active:
		$AnimatedSprite2D.play("active")
		$CollisionShape2D.set_deferred("disabled", false)
		if has_node("StaticBody2D/CollisionShape2D"):
			$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	else:
		$AnimatedSprite2D.play("inactive")
		$CollisionShape2D.set_deferred("disabled", true)
		if has_node("StaticBody2D/CollisionShape2D"):
			$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().reload_current_scene()