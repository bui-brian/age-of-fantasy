extends Node2D

@onready var player_units = get_node("/root/World/PlayerUnits")
@onready var enemy_units = get_node("/root/World/EnemyUnits")
@onready var player_spawner: UnitSpawner = $PlayerSpawner
@onready var enemy_spawner: UnitSpawner = $EnemySpawner

const lm_scene_path = "res://scenes/units/lightning_mage.tscn"
const knight_scene_path = "res://scenes/units/knight.tscn"

# --- Button handlers ---
func _on_unit_1_button_pressed() -> void:
	# Preload all units
	var lm_scene1 = preload(lm_scene_path).instantiate()
	var lm_scene2 = preload(lm_scene_path).instantiate()
	var lm_scene3 = preload(lm_scene_path).instantiate()
	
	var knight_scene1 = preload(knight_scene_path).instantiate()
	var knight_scene2 = preload(knight_scene_path).instantiate()
	var knight_scene3 = preload(knight_scene_path).instantiate()

	# Configure units and construct unit spawners
	var player_spawn_mid = player_spawner.spawn_unit(lm_scene1, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(-900, 50))
	var player_spawn_top = player_spawner.spawn_unit(lm_scene2, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(-900, -100))
	var player_spawn_bot = player_spawner.spawn_unit(lm_scene3, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(-900, 250))
	
	var enemy_spawn_mid = enemy_spawner.spawn_unit(knight_scene1, Unit.Faction.ENEMY, Vector2.LEFT, Vector2(900, 75))
	var enemy_spawn_top = enemy_spawner.spawn_unit(knight_scene2, Unit.Faction.ENEMY, Vector2.LEFT, Vector2(900, -100))
	var enemy_spawn_bot = enemy_spawner.spawn_unit(knight_scene3, Unit.Faction.ENEMY, Vector2.LEFT, Vector2(900, 250))

	# Add units to the main scene
	player_units.add_child(player_spawn_mid)
	player_units.add_child(player_spawn_top)
	player_units.add_child(player_spawn_bot)
	
	enemy_units.add_child(enemy_spawn_mid)
	enemy_units.add_child(enemy_spawn_top)
	enemy_units.add_child(enemy_spawn_bot)
