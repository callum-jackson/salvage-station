extends Area2D

signal hit

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$CollisionShape2D.set_deferred("disabled", true)
		hit.emit()
		queue_free()