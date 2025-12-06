extends Node

var fuel_cells_remaining

func _ready() -> void:
	var current_scene = get_tree().current_scene.name
	print(current_scene)
	if current_scene == "Level02":
		game_state.has_thrusters = false
	
	var fuel_cells = get_tree().get_nodes_in_group("fuel_cells")
	fuel_cells_remaining = fuel_cells.size()
	for fuel_cell in fuel_cells:
		fuel_cell.hit.connect(_on_fuel_cell_hit)


func _on_fuel_cell_hit() -> void:
	fuel_cells_remaining -= 1
	if fuel_cells_remaining == 0:
		$Exit.open_door()