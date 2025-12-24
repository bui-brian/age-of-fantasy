extends Node2D

@onready var unit_1_button: TextureButton = $UI/SideBar/VBoxContainer/Unit1_Button

const lm_scene_path = "res://scenes/units/lightning_sorc.tscn"
const knight_scene_path = "res://scenes/units/knight.tscn"

func _ready() -> void:
	unit_1_button.pressed.connect(_on_unit_1_button_pressed)

func spawn_unit(unit_scene: Variant, unit_group: Unit.Faction, unit_direction: Vector2, unit_position: Vector2):
	var temp_scene = unit_scene
	temp_scene.faction = unit_group
	temp_scene.direction = unit_direction.x
	temp_scene.scale.x = unit_direction.x
	temp_scene.global_position = unit_position
	temp_scene.scale *= Vector2(1, 1)
	
	return temp_scene

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
	var player_spawn_mid = spawn_unit(lm_scene1, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(-750, 50))
	var player_spawn_top = spawn_unit(lm_scene2, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(-750, -100))
	var player_spawn_bot = spawn_unit(lm_scene3, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(-750, 250))
	
	var enemy_spawn_mid = spawn_unit(knight_scene1, Unit.Faction.ENEMY, Vector2.LEFT, Vector2(750, 75))
	var enemy_spawn_top = spawn_unit(knight_scene2, Unit.Faction.ENEMY, Vector2.LEFT, Vector2(750, -100))
	var enemy_spawn_bot = spawn_unit(knight_scene3, Unit.Faction.ENEMY, Vector2.LEFT, Vector2(750, 250))

	# Add units to the main scene
	self.add_child(player_spawn_mid)
	self.add_child(player_spawn_top)
	self.add_child(player_spawn_bot)
	
	self.add_child(enemy_spawn_mid)
	self.add_child(enemy_spawn_top)
	self.add_child(enemy_spawn_bot)
