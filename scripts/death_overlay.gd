extends CanvasLayer

func show_overlay() -> void:
	visible = true
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()