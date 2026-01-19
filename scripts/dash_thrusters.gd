extends Area2D

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$CollisionShape2D.set_deferred("disabled", true)
		game_state.has_thrusters = true
		$AnimatedSprite2D.visible = false
		$PickupSound.play()
		await $PickupSound.finished
		queue_free()