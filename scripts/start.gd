extends CanvasLayer

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("confirm") and visible == true:
		get_tree().change_scene_to_file("res://scenes/level_01.tscn")