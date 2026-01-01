class_name Hurtbox extends Area2D

@onready var stats: Stats = owner.stats
#@onready var owner_ani_player = owner.get_node("AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monitoring = false

func receive_hit(damage: int) -> void:
	if not stats:
		return
		
	stats.health -= damage # health_changed or health_depleted signal emits
	
	if stats.health <= 0:
		#owner_ani_player.set_current_animation("death")
		#await get_tree().create_timer(1.0).timeout
		#owner_health_bar.queue_free()
		#stats.health_depleted.emit(stats.unit_lane)
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
		
		# Remove unit from scene
		owner.queue_free()
