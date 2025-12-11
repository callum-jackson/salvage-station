extends Node

var fuel_cells_remaining

func _ready() -> void:
	var fuel_cells = get_tree().get_nodes_in_group("fuel_cells")
	fuel_cells_remaining = fuel_cells.size()
	for fuel_cell in fuel_cells:
		fuel_cell.hit.connect(_on_fuel_cell_hit)

func next_level() -> void:
	var current_scene_root = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
	var current_scene_name = current_scene_root.name
	
	if current_scene_name == "Level01":
		get_tree().change_scene_to_file("res://scenes/level_02.tscn")
	elif current_scene_name == "Level02":
		get_tree().change_scene_to_file("res://scenes/level_03.tscn")
	elif current_scene_name == "Level03":
		get_tree().change_scene_to_file("res://scenes/level_04.tscn")
	elif current_scene_name == "Level04":
		get_tree().change_scene_to_file("res://scenes/level_05.tscn")
	elif current_scene_name == "Level05":
		get_tree().quit()

func died() -> void:
	var current_scene_root = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
	current_scene_root.get_node("Player").queue_free()
	current_scene_root.get_node("DeathOverlay").show_overlay()

func _on_fuel_cell_hit() -> void:
	fuel_cells_remaining -= 1
	if fuel_cells_remaining == 0:
		var current_scene_root = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
		if current_scene_root.has_node("Exit"):
			current_scene_root.get_node("Exit").open_door()