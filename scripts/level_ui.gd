extends CanvasLayer

@onready var timer_label = $TimerContainer/TimerLabel
@onready var dash_container = $DashContainer
@onready var cooldown_bar = $DashContainer/CooldownBar

func _ready() -> void:
	update_timer_ui()
	update_dash_ui()

func _process(delta: float) -> void:
	update_timer_ui()
	update_dash_ui()

func update_timer_ui() -> void:
	if game_state.timer_running:
		var time = game_state.level_elapsed_time
		var minutes = int(time / 60)
		var seconds = int(time) % 60
		var milliseconds = int((time - int(time)) * 100)
		timer_label.text = "%02d:%02d.%02d" % [minutes, seconds, milliseconds]
	else:
		timer_label.text = "00:00.00"

func update_dash_ui() -> void:
	if not game_state.has_thrusters:
		dash_container.visible = false
		return
	
	dash_container.visible = true
	
	if game_state.dash_available:
		cooldown_bar.value = 100
		dash_container.modulate = Color(1, 1, 1, 1)
	else:
		var player = get_tree().get_first_node_in_group("player")
		if player:
			var cooldown_progress = 1.0 - (player.cooldown_timer / game_state.dash_cooldown_time)
			cooldown_bar.value = cooldown_progress * 100
			dash_container.modulate = Color(0.5, 0.5, 0.5, 1)
