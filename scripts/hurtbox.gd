class_name Hurtbox extends Area2D

@onready var stats: Stats = owner.stats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monitoring = false
	stats.health_depleted.connect(_on_health_depleted)

func receive_hit(damage: int) -> void:
	if not stats:
		return
		
	stats.health -= damage # health_changed or health_depleted signal emits

func _on_health_depleted() -> void:
	if stats.health > 0:
		return
		
	match owner.current_lane:
		Unit.UnitLane.TOP:
			if GameState.player_unit_count_top < 1:
				#GameState.player_unit_count_top = 0
				GameState.set_player_count(GameState.player_unit_count_mid, 0, GameState.player_unit_count_bot)
			else:
				#GameState.player_unit_count_top -= 1
				GameState.set_player_count(GameState.player_unit_count_mid, GameState.player_unit_count_top-1, GameState.player_unit_count_bot)
		Unit.UnitLane.MID:
			if GameState.player_unit_count_mid < 1:
				#GameState.player_unit_count_mid = 0
				GameState.set_player_count(0, GameState.player_unit_count_top, GameState.player_unit_count_bot)
			else:
				#GameState.player_unit_count_mid -= 1
				GameState.set_player_count(GameState.player_unit_count_mid-1, GameState.player_unit_count_top, GameState.player_unit_count_bot)
		Unit.UnitLane.BOT:
			if GameState.player_unit_count_bot < 1:
				#GameState.player_unit_count_bot = 0
				GameState.set_player_count(GameState.player_unit_count_mid, GameState.player_unit_count_top, 0)
			else:
				#GameState.player_unit_count_bot -= 1
				GameState.set_player_count(GameState.player_unit_count_mid, GameState.player_unit_count_top, GameState.player_unit_count_bot-1)
	
	# Stop unit's processes
	owner.set_process(false)
	owner.set_physics_process(false)
	owner.set_process_input(false)
	owner.velocity = Vector2.ZERO
	owner.animation_player.set_current_animation("death")
	await owner.animation_player.animation_finished
	
	# Remove unit from scene
	owner.queue_free()
