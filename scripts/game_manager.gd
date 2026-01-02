extends Node

var fuel_cells_remaining

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if game_state.timer_running:
		game_state.level_elapsed_time += delta

func start_timer() -> void:
	game_state.level_start_time = Time.get_ticks_msec() / 1000.0
	game_state.level_elapsed_time = 0.0
	game_state.timer_running = true

func stop_timer() -> void:
	game_state.timer_running = false
	game_state.level_complete_time = game_state.level_elapsed_time

func setup_level() -> void:
	var fuel_cells = get_tree().get_nodes_in_group("fuel_cells")
	fuel_cells_remaining = fuel_cells.size()
	for fuel_cell in fuel_cells:
		fuel_cell.hit.connect(_on_fuel_cell_hit)
		   
	start_timer()

func next_level() -> void:
	stop_timer()
	
	var current_scene_root = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
	var current_scene_name = current_scene_root.name
	
	if current_scene_name == "Level01":
		get_tree().change_scene_to_file("res://scenes/level_02.tscn")
		await get_tree().tree_changed
		setup_level()
	elif current_scene_name == "Level02":
		get_tree().change_scene_to_file("res://scenes/level_03.tscn")
		await get_tree().tree_changed
		setup_level()
	elif current_scene_name == "Level03":
		get_tree().change_scene_to_file("res://scenes/level_04.tscn")
		await get_tree().tree_changed
		setup_level()
	elif current_scene_name == "Level04":
		get_tree().change_scene_to_file("res://scenes/level_05.tscn")
		await get_tree().tree_changed
		setup_level()
	elif current_scene_name == "Level05":
		get_tree().change_scene_to_file("res://scenes/start.tscn")
		await get_tree().tree_changed
		setup_level()

func died() -> void:
	stop_timer()
	
	var current_scene_root = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
	current_scene_root.get_node("Player").queue_free()
	current_scene_root.get_node("DeathOverlay").show_overlay()

func _on_fuel_cell_hit() -> void:
	fuel_cells_remaining -= 1
	if fuel_cells_remaining == 0:
		var current_scene_root = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
		if current_scene_root.has_node("Exit"):
			current_scene_root.get_node("Exit").open_door()

func level_complete() -> void:
	stop_timer()
	
	var current_scene_root = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
	current_scene_root.get_node("Player").queue_free()
	var current_scene = get_tree().current_scene.name
	if current_scene == "Level05":
		current_scene_root.get_node("GameCompleteOverlay").show_overlay()
	else:
		current_scene_root.get_node("LevelCompleteOverlay").show_overlay()