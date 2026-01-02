extends CanvasLayer

func show_overlay() -> void:
	var time = game_state.level_complete_time
	var minutes = int(time / 60)
	var seconds = int(time) % 60
	var milliseconds = int((time - int(time)) * 100)
	$TimerLabel.text = "%02d:%02d.%02d" % [minutes, seconds, milliseconds]
	await get_tree().create_timer(0.5).timeout
	var current_scene_root = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
	current_scene_root.get_node("LevelUI/TimerContainer").visible = false
	visible = true

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("confirm") and visible == true:
		game_manager.next_level()