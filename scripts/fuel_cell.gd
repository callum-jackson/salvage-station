extends Area2D

signal hit

func _on_body_entered(body: Node2D) -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	hit.emit()
	queue_free()