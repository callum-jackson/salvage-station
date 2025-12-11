extends CanvasLayer

func show_overlay() -> void:
	await get_tree().create_timer(1.0).timeout
	visible = true

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("confirm") and visible == true:
		get_tree().reload_current_scene()