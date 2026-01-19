extends Area2D

signal hit

var collected = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not collected:
		collected = true
		$CollisionShape2D.set_deferred("disabled", true)
		$AnimatedSprite2D.visible = false
		hit.emit()
		$PickupSound.play()
		await $PickupSound.finished
		queue_free()