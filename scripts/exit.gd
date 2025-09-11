extends Node2D

func _ready() -> void:
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	$Area2D/CollisionShape2D.set_deferred("disabled", true)

func open_door() -> void:
	$AnimatedSprite2D.play("open")
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_area_2d_body_entered(body: Node2D) -> void:
	queue_free()