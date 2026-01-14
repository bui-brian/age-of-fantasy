# health.gd - Health Component
class_name Health
extends Node2D

signal health_depleted
signal health_changed(cur_health: int)

@onready var end_screen: Control = $"../../../GUI/EndScreen"

@export var current_max_health: int = 100

var current_health: int = 0: set = _on_health_set

func _ready() -> void:
	health_depleted.connect(_on_health_depleted)
	health_depleted.connect(_on_global_health_depleted)

func _init() -> void:
	setup_stats.call_deferred()

func setup_stats() -> void:
	current_health = current_max_health

func _on_health_set(new_value: int) -> void:
	current_health = clampi(new_value, 0, current_max_health)
	health_changed.emit(current_health)
	
	if current_health <= 0:
		health_depleted.emit()

func _on_global_health_depleted() -> void:
	if not Tower:
		return
	
	if GameState.player_current_health <= 0:
		end_screen.label.text = "You lose!"
		end_screen.show() 
	if GameState.enemy_current_health <= 0:
		end_screen.label.text = "You win!"
		end_screen.show()
	

func _on_health_depleted() -> void:
	if current_health > 0 or owner is Tower:
		return
		
	match owner.current_lane:
		Unit.UnitLane.TOP:
			if GameState.player_unit_count_top < 1:
				GameState.set_player_count(GameState.player_unit_count_mid, 0, GameState.player_unit_count_bot)
			else:
				GameState.set_player_count(GameState.player_unit_count_mid, GameState.player_unit_count_top-1, GameState.player_unit_count_bot)
		Unit.UnitLane.MID:
			if GameState.player_unit_count_mid < 1:
				GameState.set_player_count(0, GameState.player_unit_count_top, GameState.player_unit_count_bot)
			else:
				GameState.set_player_count(GameState.player_unit_count_mid-1, GameState.player_unit_count_top, GameState.player_unit_count_bot)
		Unit.UnitLane.BOT:
			if GameState.player_unit_count_bot < 1:
				GameState.set_player_count(GameState.player_unit_count_mid, GameState.player_unit_count_top, 0)
			else:
				GameState.set_player_count(GameState.player_unit_count_mid, GameState.player_unit_count_top, GameState.player_unit_count_bot-1)
	
	# Stop unit's processes
	owner.set_process(false)
	owner.set_physics_process(false)
	owner.set_process_input(false)
	#owner.velocity = Vector2.ZERO
	owner.animation_player.set_current_animation("death")
	await owner.animation_player.animation_finished
	
	# Remove unit from scene
	owner.queue_free()
