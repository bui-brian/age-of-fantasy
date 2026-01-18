# enemy_controller.gd
class_name EnemyController extends Node

@onready var timer: Timer = $Timer

@export var unit_spawner: UnitSpawner
@export var tower_controller: TowerController

var enemy_tick_rate: float = 5.0
var prioritize_lane: int = 0 # top = 1, mid = 2, bot = 3

var top_under_attack: bool = false
var mid_under_attack: bool = false
var bot_under_attack: bool = false

func _ready() -> void:
	tower_controller.enemy_top_under_attack.connect(_set_top_under_attack)
	tower_controller.enemy_mid_under_attack.connect(_set_mid_under_attack)
	tower_controller.enemy_bot_under_attack.connect(_set_bot_under_attack)
	
	timer.wait_time = enemy_tick_rate
	timer.timeout.connect(enemy_ai_tick)
	timer.start()

func _set_top_under_attack(under_attack: bool) -> void:
	top_under_attack = under_attack

func _set_mid_under_attack(under_attack: bool) -> void:
	mid_under_attack = under_attack

func _set_bot_under_attack(under_attack: bool) -> void:
	bot_under_attack = under_attack

func enemy_ai_tick():
	# Check lane individually to decide on sending a unit
		# Defend Tower -> Match units -> If none in lane, send units

	# If tower is being attacked, send unit to defend
	if top_under_attack:
		unit_spawner.spawn_unit_lane("sorc_scene", Util.Faction.ENEMY, Util.Lane.TOP, 50)
	
	if mid_under_attack:
		unit_spawner.spawn_unit_lane("sorc_scene", Util.Faction.ENEMY, Util.Lane.MID, 50)
	
	if bot_under_attack:
		unit_spawner.spawn_unit_lane("sorc_scene", Util.Faction.ENEMY, Util.Lane.BOT, 50)
	
	# Match amount of player units in each lane
	if GameState.player_unit_count_top > GameState.enemy_unit_count_top:
		unit_spawner.spawn_unit_lane("dm_scene", Util.Faction.ENEMY, Util.Lane.TOP, 50)
	
	if GameState.player_unit_count_mid > GameState.enemy_unit_count_mid:
		unit_spawner.spawn_unit_lane("dm_scene", Util.Faction.ENEMY, Util.Lane.MID, 50)
	
	if GameState.player_unit_count_bot > GameState.enemy_unit_count_bot:
		unit_spawner.spawn_unit_lane("dm_scene", Util.Faction.ENEMY, Util.Lane.BOT, 50)
	
	# If there are no player units in lane, send 1 unit to attack
	if GameState.player_unit_count_top == 0:
		unit_spawner.spawn_unit_lane("knight_scene", Util.Faction.ENEMY, Util.Lane.TOP, 50)
	
	if GameState.player_unit_count_mid == 0:
		unit_spawner.spawn_unit_lane("knight_scene", Util.Faction.ENEMY, Util.Lane.MID, 50)
	
	if GameState.player_unit_count_bot == 0:
		unit_spawner.spawn_unit_lane("knight_scene", Util.Faction.ENEMY, Util.Lane.BOT, 50)

	# Priority function below - decide to keep or not

	# First, check player unit count across each lane to determine which lane to prioritize
	#if GameState.player_unit_count_top > GameState.player_unit_count_mid and GameState.player_unit_count_top > GameState.player_unit_count_bot:
		#prioritize_lane = 1
	#elif GameState.player_unit_count_mid > GameState.player_unit_count_top and GameState.player_unit_count_mid > GameState.player_unit_count_bot:
		#prioritize_lane = 2
	#elif GameState.player_unit_count_bot > GameState.player_unit_count_mid and GameState.player_unit_count_bot > GameState.player_unit_count_top:
		#prioritize_lane = 3
	#
	#match prioritize_lane:
		#1: # Top lane prio
			## If there are more player units than enemy units
			#if GameState.player_unit_count_top > GameState.enemy_unit_count_top and GameState.enemy_gold >= 50:
				#unit_spawner.spawn_unit("sorc_scene", Util.Faction.ENEMY, Vector2.LEFT, Vector2(750, -100), Util.Lane.TOP)
				#enemy_gold_spent.emit(50)
			#elif GameState.player_unit_count_top < GameState.enemy_unit_count_mid:
				#pass
			#elif GameState.player_unit_count_top == 0 and GameState.enemy_gold >= 50:
				#unit_spawner.spawn_unit("knight_scene", Util.Faction.ENEMY, Vector2.LEFT, Vector2(750, -100), Util.Lane.TOP)
				#enemy_gold_spent.emit(50)
			#
			#GameState.set_enemy_count(GameState.enemy_unit_count_top+1, GameState.enemy_unit_count_mid, GameState.enemy_unit_count_bot)
		#2: # Mid lane prio
			## If there are more player units than enemy units
			#if GameState.player_unit_count_mid > GameState.enemy_unit_count_mid and GameState.enemy_gold >= 50:
				#unit_spawner.spawn_unit("sorc_scene", Util.Faction.ENEMY, Vector2.LEFT, Vector2(750, 50), Util.Lane.MID)
				#enemy_gold_spent.emit(50)
			#elif GameState.player_unit_count_mid < GameState.enemy_unit_count_mid:
				#pass
			#elif GameState.player_unit_count_mid == 0 and GameState.enemy_gold >= 50:
				#unit_spawner.spawn_unit("knight_scene", Util.Faction.ENEMY, Vector2.LEFT, Vector2(750, 50), Util.Lane.MID)
				#enemy_gold_spent.emit(50)
			#
			#GameState.set_enemy_count(GameState.enemy_unit_count_top, GameState.enemy_unit_count_mid+1, GameState.enemy_unit_count_bot)
		#3: # Bot lane prio
			#if GameState.player_unit_count_bot > GameState.enemy_unit_count_bot and GameState.enemy_gold >= 50:
				#unit_spawner.spawn_unit("sorc_scene", Util.Faction.ENEMY, Vector2.LEFT, Vector2(750, 250), Util.Lane.BOT)
				#enemy_gold_spent.emit(50)
			#elif GameState.player_unit_count_bot < GameState.enemy_unit_count_bot:
				#pass
			#elif GameState.player_unit_count_bot == 0 and GameState.enemy_gold >= 50:
				#unit_spawner.spawn_unit("knight_scene", Util.Faction.ENEMY, Vector2.LEFT, Vector2(750, 250), Util.Lane.BOT)
				#enemy_gold_spent.emit(50)
			#
			#GameState.set_enemy_count(GameState.enemy_unit_count_top, GameState.enemy_unit_count_mid, GameState.enemy_unit_count_bot+1)
	#
	#prioritize_lane = 0
