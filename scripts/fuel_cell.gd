extends Area2D

signal hit

var collected = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not collected:
		collected = true
		$CollisionShape2D.set_deferred("disabled", true)
		hit.emit()
		queue_free()