class_name UnitSpawner extends Node

const sorc_scene_path = "res://scenes/units/lightning_sorc.tscn"
const knight_scene_path = "res://scenes/units/knight.tscn"
const dm_scene_path = "res://scenes/units/dark_magician.tscn"

func spawn_unit(unit_scene: Variant, unit_group: Unit.Faction, unit_direction: Vector2, unit_position: Vector2, unit_lane: Unit.UnitLane):
	var temp_scene = unit_scene
	
	temp_scene.faction = unit_group
	temp_scene.direction = unit_direction.x
	temp_scene.scale.x = unit_direction.x
	temp_scene.global_position = unit_position
	temp_scene.scale *= Vector2(1, 1)
	temp_scene.current_lane = unit_lane
	
	return temp_scene

func spawn_unit_lane(unit) -> void:
	get_tree().current_scene.add_child(unit)
