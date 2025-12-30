class_name UnitSpawner extends Node2D

@onready var tower_buttons: Control = $"../UI/TowerButtons"

signal gold_spent(gold_amount)

const sorc_scene_path = "res://scenes/units/lightning_sorc.tscn"
const knight_scene_path = "res://scenes/units/knight.tscn"
const dm_scene_path = "res://scenes/units/dark_magician.tscn"

var player_unit_count_mid: int = 0
var player_unit_count_top: int = 0
var player_unit_count_bot: int = 0

func spawn_unit(unit_scene: Variant, unit_group: Unit.Faction, unit_direction: Vector2, unit_position: Vector2):
	var temp_scene = unit_scene
	temp_scene.faction = unit_group
	temp_scene.direction = unit_direction.x
	temp_scene.scale.x = unit_direction.x
	temp_scene.global_position = unit_position
	temp_scene.scale *= Vector2(1, 1)
	
	return temp_scene

func spawn_unit_lane(unit) -> void:
	get_tree().current_scene.add_child(unit)
	gold_spent.emit(50)
	player_unit_count_mid += 1
	GameState.set_player_count(player_unit_count_mid, player_unit_count_top, player_unit_count_bot)
