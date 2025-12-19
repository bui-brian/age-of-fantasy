# spawns units facing in left/right direction given a scale_x and global position 

class_name UnitSpawner extends Node2D

func spawn_unit(unit_scene, unit_group: Unit.Faction, unit_direction: Vector2, unit_position: Vector2):
	
	var temp_scene = unit_scene
	#temp_scene.add_to_group(unit_group)
	temp_scene.faction = unit_group
	temp_scene.direction = unit_direction.x
	temp_scene.scale.x = unit_direction.x
	temp_scene.global_position = unit_position
	temp_scene.scale *= Vector2(1.25, 1.25)
	
	return temp_scene
