# health.gd - Health Component
class_name Health
extends Node2D

signal health_depleted
signal health_changed(cur_health: int)

@export var current_max_health: int = 100

var current_health: int = 100: set = _on_health_set

func _ready() -> void:
	health_depleted.connect(_on_health_depleted)

func _init() -> void:
	setup_stats.call_deferred()

func setup_stats() -> void:
	current_health = current_max_health

func _on_health_set(new_value: int) -> void:
	if current_health == new_value:
		return
	
	current_health = clampi(new_value, 0, current_max_health)
	health_changed.emit(current_health)
	
	if current_health <= 0:
		health_depleted.emit()

func _on_health_depleted() -> void:
	if current_health > 0 or owner is Tower:
		return
	
	# Subtract 1 from Player/Enemy unit count for each unit death
	match owner.current_lane:
		Util.Lane.TOP:
			# Player TOP
			if owner.faction == Util.Faction.PLAYER:
				GameState.set_player_count_top(GameState.player_unit_count_top - 1)
			
			# Enemy TOP
			if owner.faction == Util.Faction.ENEMY:
				GameState.set_enemy_count_top(GameState.enemy_unit_count_top - 1)
				
		Util.Lane.MID:
			# Player MID
			if owner.faction == Util.Faction.PLAYER:
				GameState.set_player_count_mid(GameState.player_unit_count_mid - 1)
			
			# Enemy MID
			if owner.faction == Util.Faction.ENEMY:
				GameState.set_enemy_count_mid(GameState.enemy_unit_count_mid - 1)
			
		Util.Lane.BOT:
			# Player BOT
			if owner.faction == Util.Faction.PLAYER:
				GameState.set_player_count_bot(GameState.player_unit_count_bot - 1)
			
			# Enemy BOT
			if owner.faction == Util.Faction.ENEMY:
				GameState.set_enemy_count_bot(GameState.enemy_unit_count_bot - 1)
	
	# Stop unit's processes
	owner.set_process(false)
	owner.set_physics_process(false)
	owner.set_process_input(false)
	#owner.velocity = Vector2.ZERO
	owner.animation_player.set_current_animation("death")
	await owner.animation_player.animation_finished
	
	# Remove unit from scene
	owner.queue_free()
