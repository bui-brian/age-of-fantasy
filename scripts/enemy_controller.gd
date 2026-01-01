# enemy_controller.gd
extends Node2D

@export var unit_spawner: UnitSpawner
@onready var timer: Timer = $Timer

signal enemy_gold_spent(gpld_spent)

var enemy_tick_rate: float = 2.0
var prioritize_lane: int = 0 # top = 1, mid = 2, bot = 3

const sorc_scene_path = "res://scenes/units/lightning_sorc.tscn"
const knight_scene_path = "res://scenes/units/knight.tscn"
const dm_scene_path = "res://scenes/units/dark_magician.tscn"

func _ready() -> void:
	timer.wait_time = enemy_tick_rate
	timer.timeout.connect(enemy_ai_tick)
	timer.start()

func enemy_ai_tick():
	# If enemy cannot afford lowest unit, pass
	if GameState.enemy_gold < 50:
		return
	#print("Top count: ", GameState.player_unit_count_top)
	#print("Mid count: ", GameState.player_unit_count_mid)
	#print("Bot count: ", GameState.player_unit_count_bot)
	#print("==============")
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
				# Spawn Lighting Sorc
				# 	Preload Sorceress scene
				var sorc_scene = preload(sorc_scene_path).instantiate()
				# Construct player Sorceress unit
				var sorc_unit = unit_spawner.spawn_unit(sorc_scene, Unit.Faction.ENEMY, Vector2.LEFT, Vector2(750, -100), Unit.UnitLane.TOP)
				unit_spawner.spawn_unit_lane(sorc_unit)
				# Subtract 50 gold from enemy
				enemy_gold_spent.emit(50)
			elif GameState.player_unit_count_top < GameState.enemy_unit_count_mid:
				pass
			elif GameState.player_unit_count_top == 0 and GameState.enemy_gold >= 50:
				# Spawn Knight
				# 	Preload Knight scene
				var knight_scene = preload(knight_scene_path).instantiate()
				# Construct player Knight unit
				var knight_unit = unit_spawner.spawn_unit(knight_scene, Unit.Faction.ENEMY, Vector2.LEFT, Vector2(750, -100), Unit.UnitLane.TOP)
				unit_spawner.spawn_unit_lane(knight_unit)
				# Subtract 50 gold from enemy
				enemy_gold_spent.emit(50)
		2: # Mid lane prio
			# If there are more player units than enemy units
			if GameState.player_unit_count_mid > GameState.enemy_unit_count_mid and GameState.enemy_gold >= 50:
				# Spawn Lighting Sorc
				# 	Preload Sorceress scene
				var sorc_scene = preload(sorc_scene_path).instantiate()
				# Construct player Sorceress unit
				var sorc_unit = unit_spawner.spawn_unit(sorc_scene, Unit.Faction.ENEMY, Vector2.LEFT, Vector2(750, 50), Unit.UnitLane.MID)
				unit_spawner.spawn_unit_lane(sorc_unit)
				# Subtract 50 gold from enemy
				enemy_gold_spent.emit(50)
			elif GameState.player_unit_count_mid < GameState.enemy_unit_count_mid:
				pass
			elif GameState.player_unit_count_mid == 0 and GameState.enemy_gold >= 50:
				# Spawn Knight
				var knight_scene = preload(knight_scene_path).instantiate()
				# Construct player Knight unit
				var knight_unit = unit_spawner.spawn_unit(knight_scene, Unit.Faction.ENEMY, Vector2.LEFT, Vector2(750, 50), Unit.UnitLane.MID)
				unit_spawner.spawn_unit_lane(knight_unit)
				# Subtract 50 gold from enemy
				enemy_gold_spent.emit(50)
		3: # Bot lane prio
			if GameState.player_unit_count_bot > GameState.enemy_unit_count_bot and GameState.enemy_gold >= 50:
				# Spawn Lighting Sorc
				# 	Preload Sorceress scene
				var sorc_scene = preload(sorc_scene_path).instantiate()
				# Construct player Sorceress unit
				var sorc_unit = unit_spawner.spawn_unit(sorc_scene, Unit.Faction.ENEMY, Vector2.LEFT, Vector2(750, 250), Unit.UnitLane.BOT)
				unit_spawner.spawn_unit_lane(sorc_unit)
				# Subtract 50 gold from enemy
				enemy_gold_spent.emit(50)
			elif GameState.player_unit_count_bot < GameState.enemy_unit_count_bot:
				pass
			elif GameState.player_unit_count_bot == 0 and GameState.enemy_gold >= 50:
				# Spawn Knight
				var knight_scene = preload(knight_scene_path).instantiate()
				# Construct player Knight unit
				var knight_unit = unit_spawner.spawn_unit(knight_scene, Unit.Faction.ENEMY, Vector2.LEFT, Vector2(750, 250), Unit.UnitLane.BOT)
				unit_spawner.spawn_unit_lane(knight_unit)
				# Subtract 50 gold from enemy
				enemy_gold_spent.emit(50)
	
	prioritize_lane = 0
