extends Node2D

@onready var player_units = get_node("/root/World/PlayerUnits")
@onready var enemy_units = get_node("/root/World/EnemyUnits")
@onready var player_spawner: UnitSpawner = $PlayerSpawner
@onready var enemy_spawner: UnitSpawner = $EnemySpawner

const lm_scene_path = "res://scenes/units/lightning_mage.tscn"
const knight_scene_path = "res://scenes/units/knight.tscn"

func _ready():
	pass
	#player_spawner = UnitSpawner.new("player", 1, Vector2.RIGHT, Vector2(200, 400))
	#enemy_spawner = UnitSpawner.new("enemy", -1, Vector2.LEFT, Vector2(1000, 400))

# --- Button handlers ---
func _on_unit_1_button_pressed() -> void:
	var lm_scene = preload(lm_scene_path).instantiate()
	var player_unit = player_spawner.spawn_unit(lm_scene, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(-900, 75))
	player_units.add_child(player_unit)
	
	var knight_scene = preload(knight_scene_path).instantiate()
	var enemy_unit = enemy_spawner.spawn_unit(knight_scene, Unit.Faction.ENEMY, Vector2.LEFT, Vector2(900, 75))
	enemy_units.add_child(enemy_unit)
