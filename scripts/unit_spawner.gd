class_name UnitSpawner extends Node2D

@onready var tower_buttons: Control = $"../UI/TowerButtons"

signal gold_spent(gold_amount)

const sorc_scene_path = "res://scenes/units/lightning_sorc.tscn"
const knight_scene_path = "res://scenes/units/knight.tscn"
const dm_scene_path = "res://scenes/units/dark_magician.tscn"

var mid_toggle: bool = false
var top_toggle: bool = false
var bot_toggle: bool = false

var player_unit_count_mid: int = 0
var player_unit_count_top: int = 0
var player_unit_count_bot: int = 0

func _ready() -> void:
	tower_buttons.toggled.connect(_set_toggled)

func spawn_unit(unit_scene: Variant, unit_group: Unit.Faction, unit_direction: Vector2, unit_position: Vector2):
	var temp_scene = unit_scene
	temp_scene.faction = unit_group
	temp_scene.direction = unit_direction.x
	temp_scene.scale.x = unit_direction.x
	temp_scene.global_position = unit_position
	temp_scene.scale *= Vector2(1, 1)
	
	return temp_scene

func _set_toggled(MID_TOGGLE: bool, TOP_TOGGLE: bool, BOT_TOGGLE: bool) -> void:
	mid_toggle = MID_TOGGLE
	top_toggle = TOP_TOGGLE
	bot_toggle = BOT_TOGGLE

func spawn_unit_lane() -> void:
	if mid_toggle:
		#var mid_spawn = preload(sorc_scene_path).instantiate()
		var mid_spawn = preload(dm_scene_path).instantiate()
		var player_spawn_mid = spawn_unit(mid_spawn, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(-750, 50))
		get_tree().current_scene.add_child(player_spawn_mid)
		gold_spent.emit(50)
		player_unit_count_mid += 1
		#player_unit_count.emit(player_unit_count_mid, player_unit_count_top, player_unit_count_bot)
		GameState.set_player_count(player_unit_count_mid, player_unit_count_top, player_unit_count_bot)
	if top_toggle:
		var top_spawn = preload(sorc_scene_path).instantiate()
		var player_spawn_top = spawn_unit(top_spawn, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(-750, -100))
		get_tree().current_scene.add_child(player_spawn_top)
		gold_spent.emit(50)
		player_unit_count_top += 1
		GameState.set_player_count(player_unit_count_mid, player_unit_count_top, player_unit_count_bot)
	if bot_toggle:
		var bot_spawn = preload(sorc_scene_path).instantiate()
		var player_spawn_bot = spawn_unit(bot_spawn, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(-750, 250))
		get_tree().current_scene.add_child(player_spawn_bot)
		gold_spent.emit(50)
		player_unit_count_bot += 1
		GameState.set_player_count(player_unit_count_mid, player_unit_count_top, player_unit_count_bot)

func spawn_unit_mid() -> void:
	#var mid_spawn = preload(sorc_scene_path).instantiate()
	var mid_spawn = preload(dm_scene_path).instantiate()
	var player_spawn_mid = spawn_unit(mid_spawn, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(750, 50))
	get_tree().current_scene.add_child(player_spawn_mid)
	gold_spent.emit(50)
	player_unit_count_mid += 1
	GameState.set_player_count(player_unit_count_mid, player_unit_count_top, player_unit_count_bot)

func spawn_unit_top() -> void:
	var top_spawn = preload(sorc_scene_path).instantiate()
	var player_spawn_top = spawn_unit(top_spawn, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(750, -100))
	get_tree().current_scene.add_child(player_spawn_top)
	gold_spent.emit(50)
	player_unit_count_top += 1
	GameState.set_player_count(player_unit_count_mid, player_unit_count_top, player_unit_count_bot)

func spawn_unit_bot() -> void:
	var bot_spawn = preload(sorc_scene_path).instantiate()
	var player_spawn_bot = spawn_unit(bot_spawn, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(750, 250))
	get_tree().current_scene.add_child(player_spawn_bot)
	gold_spent.emit(50)
	player_unit_count_bot += 1
	GameState.set_player_count(player_unit_count_mid, player_unit_count_top, player_unit_count_bot)
