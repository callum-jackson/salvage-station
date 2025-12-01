extends Control

@onready var cooldown_bar = $CooldownBar
@onready var dash_icon = $DashIcon

func _ready() -> void:
	update_ui()

func _process(delta: float) -> void:
	update_ui()

func update_ui() -> void:
	if not game_state.has_thrusters:
		visible = false
		return
	
	visible = true
	
	if game_state.dash_available:
		cooldown_bar.value = 100
		modulate = Color(1, 1, 1, 1)
	else:
		var player = get_tree().get_first_node_in_group("player")
		if player:
			var cooldown_progress = 1.0 - (player.cooldown_timer / game_state.dash_cooldown_time)
			cooldown_bar.value = cooldown_progress * 100
			modulate = Color(0.5, 0.5, 0.5, 1)