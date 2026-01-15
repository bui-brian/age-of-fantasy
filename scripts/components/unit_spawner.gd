class_name UnitSpawner extends Node

const UNIT_SCENES := {
	"sorc_scene": preload("res://scenes/units/lightning_sorc.tscn"),
	"knight_scene": preload("res://scenes/units/knight.tscn"),
	"dm_scene": preload("res://scenes/units/dark_magician.tscn")
}

signal player_gold_spent(gold_spent)

@export var button_controller: UnitButtonController
@export var tower_buttons: TowerButtons
@export var gold_controller: GoldController

var mid_toggle: bool = false
var top_toggle: bool = false
var bot_toggle: bool = false

var spawn_button_cooldown: float = 2.0
var sorceress_available: bool = true
var magician_available: bool = true
var unit_gold_cost: int = 0
var scene_str: String

func _ready() -> void:
	button_controller.sorceress_button.unit_button_pressed.connect(_on_unit_button_pressed)
	button_controller.dark_magician_button.unit_button_pressed.connect(_on_unit_button_pressed)
	button_controller.fire_mage_button.unit_button_pressed.connect(_on_unit_button_pressed)
	
	tower_buttons.toggled.connect(_set_toggled)

func spawn_unit(unit_scene: Variant, unit_group: Util.Faction, unit_direction: Vector2, unit_position: Vector2, unit_lane: Util.Lane):
	var temp_scene = unit_scene
	
	temp_scene.faction = unit_group
	temp_scene.direction = unit_direction.x
	temp_scene.scale.x = unit_direction.x
	temp_scene.global_position = unit_position
	temp_scene.scale *= Vector2(1.25, 1.25)
	temp_scene.current_lane = unit_lane
	
	return temp_scene

func spawn_unit_lane(unit) -> void:
	get_tree().current_scene.add_child(unit)

func full_spawn(unit_str: String, unit_group: Util.Faction, unit_direction: Vector2, unit_position: Vector2, unit_lane: Util.Lane):
		var unit_scene = UNIT_SCENES[unit_str].instantiate()
		var unit_instance = spawn_unit(unit_scene, unit_group, unit_direction, unit_position, unit_lane)
		spawn_unit_lane(unit_instance)

# --- Button handlers ---
func _set_toggled(MID_TOGGLE: bool, TOP_TOGGLE: bool, BOT_TOGGLE: bool) -> void:
	mid_toggle = MID_TOGGLE
	top_toggle = TOP_TOGGLE
	bot_toggle = BOT_TOGGLE

func _on_unit_button_pressed(gold_cost, unit_scene, BUTTON_AVAILABLE) -> void:
	unit_gold_cost = gold_cost
	scene_str = unit_scene
	
	if not BUTTON_AVAILABLE:
		return
	
	if top_toggle and GameState.player_gold >= gold_cost:
		full_spawn(scene_str, Util.Faction.PLAYER, Vector2.RIGHT, Vector2(-750, -200), Util.Lane.TOP)
		GameState.set_player_count(GameState.player_unit_count_mid, GameState.player_unit_count_top+1, GameState.player_unit_count_bot)
		player_gold_spent.emit(50)
	
	if mid_toggle and GameState.player_gold >= gold_cost:
		full_spawn(scene_str, Util.Faction.PLAYER, Vector2.RIGHT, Vector2(-750, 50), Util.Lane.MID)
		GameState.set_player_count(GameState.player_unit_count_mid+1, GameState.player_unit_count_top, GameState.player_unit_count_bot)
		player_gold_spent.emit(50)
	
	if bot_toggle and GameState.player_gold >= gold_cost:
		full_spawn(scene_str, Util.Faction.PLAYER, Vector2.RIGHT, Vector2(-750, 250), Util.Lane.BOT)
		GameState.set_player_count(GameState.player_unit_count_mid, GameState.player_unit_count_top, GameState.player_unit_count_bot+1)
		player_gold_spent.emit(50)
