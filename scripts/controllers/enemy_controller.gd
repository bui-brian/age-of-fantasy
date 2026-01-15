# enemy_controller.gd
class_name EnemyController extends Node

@onready var timer: Timer = $Timer

@export var unit_spawner: UnitSpawner

signal enemy_gold_spent(gold_spent)

var enemy_tick_rate: float = 2.0
var prioritize_lane: int = 0 # top = 1, mid = 2, bot = 3

func _ready() -> void:
	timer.wait_time = enemy_tick_rate
	timer.timeout.connect(enemy_ai_tick)
	timer.start()

func enemy_ai_tick():
	# If enemy cannot afford lowest unit, pass
	if GameState.enemy_gold < 50:
		return

	# First, check player unit count across each lane to determine which lane to prioritize
	if GameState.player_unit_count_top > GameState.player_unit_count_mid and GameState.player_unit_count_top > GameState.player_unit_count_bot:
		prioritize_lane = 1
	elif GameState.player_unit_count_mid > GameState.player_unit_count_top and GameState.player_unit_count_mid > GameState.player_unit_count_bot:
		prioritize_lane = 2
	elif GameState.player_unit_count_bot > GameState.player_unit_count_mid and GameState.player_unit_count_bot > GameState.player_unit_count_top:
		prioritize_lane = 3
	
	match prioritize_lane:
		1: # Top lane prio
			# If there are more player units than enemy units
			if GameState.player_unit_count_top > GameState.enemy_unit_count_top and GameState.enemy_gold >= 50:
				unit_spawner.full_spawn("sorc_scene", Util.Faction.ENEMY, Vector2.LEFT, Vector2(750, -100), Util.Lane.TOP)
				enemy_gold_spent.emit(50)
			elif GameState.player_unit_count_top < GameState.enemy_unit_count_mid:
				pass
			elif GameState.player_unit_count_top == 0 and GameState.enemy_gold >= 50:
				unit_spawner.full_spawn("knight_scene", Util.Faction.ENEMY, Vector2.LEFT, Vector2(750, -100), Util.Lane.TOP)
				enemy_gold_spent.emit(50)
			
			GameState.set_enemy_count(GameState.enemy_unit_count_top+1, GameState.enemy_unit_count_mid, GameState.enemy_unit_count_bot)
		2: # Mid lane prio
			# If there are more player units than enemy units
			if GameState.player_unit_count_mid > GameState.enemy_unit_count_mid and GameState.enemy_gold >= 50:
				unit_spawner.full_spawn("sorc_scene", Util.Faction.ENEMY, Vector2.LEFT, Vector2(750, 50), Util.Lane.MID)
				enemy_gold_spent.emit(50)
			elif GameState.player_unit_count_mid < GameState.enemy_unit_count_mid:
				pass
			elif GameState.player_unit_count_mid == 0 and GameState.enemy_gold >= 50:
				unit_spawner.full_spawn("knight_scene", Util.Faction.ENEMY, Vector2.LEFT, Vector2(750, 50), Util.Lane.MID)
				enemy_gold_spent.emit(50)
			
			GameState.set_enemy_count(GameState.enemy_unit_count_top, GameState.enemy_unit_count_mid+1, GameState.enemy_unit_count_bot)
		3: # Bot lane prio
			if GameState.player_unit_count_bot > GameState.enemy_unit_count_bot and GameState.enemy_gold >= 50:
				unit_spawner.full_spawn("sorc_scene", Util.Faction.ENEMY, Vector2.LEFT, Vector2(750, 250), Util.Lane.BOT)
				enemy_gold_spent.emit(50)
			elif GameState.player_unit_count_bot < GameState.enemy_unit_count_bot:
				pass
			elif GameState.player_unit_count_bot == 0 and GameState.enemy_gold >= 50:
				unit_spawner.full_spawn("knight_scene", Util.Faction.ENEMY, Vector2.LEFT, Vector2(750, 250), Util.Lane.BOT)
				enemy_gold_spent.emit(50)
			
			GameState.set_enemy_count(GameState.enemy_unit_count_top, GameState.enemy_unit_count_mid, GameState.enemy_unit_count_bot+1)
	
	prioritize_lane = 0
