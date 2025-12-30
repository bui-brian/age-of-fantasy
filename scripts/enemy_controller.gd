extends Node2D

@export var unit_spawner: UnitSpawner
@onready var timer: Timer = $Timer

var enemy_tick_rate: float = 1.0
var prioritize_lane: int = 0 # top = 1, mid = 2, bot = 3

func _ready() -> void:
	timer.wait_time = enemy_tick_rate
	timer.timeout.connect(enemy_ai_tick)
	timer.start()

func enemy_ai_tick():
	# If enemy cannot afford lowest unit, pass
	if GameState.enemy_gold < 50:
		print(GameState.enemy_gold)
		return
	
	# First, check player unit count across each lane to determine which lane to prioritize
	if GameState.current_player_unit_count_top > GameState.current_player_unit_count_mid and GameState.current_player_unit_count_top > GameState.current_player_unit_count_bot:
		prioritize_lane = 1
	elif GameState.current_player_unit_count_mid > GameState.current_player_unit_count_top and GameState.current_player_unit_count_mid > GameState.current_player_unit_count_bot:
		prioritize_lane = 2
	elif GameState.current_player_unit_count_bot > GameState.current_player_unit_count_mid and GameState.current_player_unit_count_bot > GameState.current_player_unit_count_top:
		prioritize_lane = 3
	
	match prioritize_lane:
		1: # Top lane prio
			# If there are more player units than enemy units
			if GameState.current_player_unit_count_top > GameState.enemy_unit_count_top and GameState.enemy_gold >= 50:
				# Spawn Lighting Sorc
				unit_spawner.spawn_unit_top()
			elif GameState.current_player_unit_count_top < GameState.enemy_unit_count_mid:
				pass
			elif GameState.current_player_unit_count_top == 0 and GameState.enemy_gold >= 50:
				# Spawn Knight
				unit_spawner.spawn_unit_top()
		2: # Mid lane prio
			# If there are more player units than enemy units
			if GameState.current_player_unit_count_mid > GameState.enemy_unit_count_mid and GameState.enemy_gold >= 50:
				# Spawn Lighting Sorc
				unit_spawner.spawn_unit_mid()
			elif GameState.current_player_unit_count_mid < GameState.enemy_unit_count_mid:
				pass
			elif GameState.current_player_unit_count_mid == 0 and GameState.enemy_gold >= 50:
				# Spawn Knight
				unit_spawner.spawn_unit_mid()
		3: # Bot lane prio
			if GameState.current_player_unit_count_bot > GameState.enemy_unit_count_bot and GameState.enemy_gold >= 50:
				# Spawn Lighting Sorc
				unit_spawner.spawn_unit_bot()
			elif GameState.current_player_unit_count_bot < GameState.enemy_unit_count_bot:
				pass
			elif GameState.current_player_unit_count_bot == 0 and GameState.enemy_gold >= 50:
				# Spawn Knight
				unit_spawner.spawn_unit_bot()
	
