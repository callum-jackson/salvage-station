extends Node

var fuel_cells_remaining

func _ready() -> void:
	var current_scene = get_tree().current_scene.name
	if current_scene == "Level02":
		game_state.has_thrusters = false
	
	var fuel_cells = get_tree().get_nodes_in_group("fuel_cells")
	fuel_cells_remaining = fuel_cells.size()
	for fuel_cell in fuel_cells:
		fuel_cell.hit.connect(_on_fuel_cell_hit)

func next_level() -> void:
	var current_scene = get_tree().current_scene.name
	if current_scene == "Level01":
		get_tree().change_scene_to_file("res://scenes/level_02.tscn")
	elif current_scene == "Level02":
		get_tree().change_scene_to_file("res://scenes/level_03.tscn")
	elif current_scene == "Level03":
		get_tree().change_scene_to_file("res://scenes/level_04.tscn")
	elif current_scene == "Level04":
		get_tree().change_scene_to_file("res://scenes/level_05.tscn")
	elif current_scene == "Level05":
		get_tree().quit()

func died() -> void:
	$DeathOverlay.show_overlay()

func _on_fuel_cell_hit() -> void:
	fuel_cells_remaining -= 1
	print("Fuel cells remaining: ", fuel_cells_remaining)
	if fuel_cells_remaining == 0:
		print("All fuel cells collected!")
		if has_node("Exit"):
			print("Exit node found")
			$Exit.open_door()
		else:
			print("Exit node NOT found!")