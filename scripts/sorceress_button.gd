extends TextureButton

@onready var unit_spawner: UnitSpawner = $"../../../../UnitSpawner"
@onready var tower_buttons: Control = $"../../../TowerButtons"

const sorc_scene_path = "res://scenes/units/lightning_sorc.tscn"

var mid_toggle: bool = false
var top_toggle: bool = false
var bot_toggle: bool = false

func _ready() -> void:
	self.pressed.connect(_sorceress_button_pressed)
	tower_buttons.toggled.connect(_set_toggled)

# --- Button handlers ---
func _sorceress_button_pressed() -> void:
	#sorc_spawner.spawn_unit_lane()
	# If toggles are on, spawn in respective lane
	if mid_toggle:
		# Preload Sorceress scene
		var sorc_scene = preload(sorc_scene_path).instantiate()
		# Construct player Sorceress unit
		var sorc_unit = unit_spawner.spawn_unit(sorc_scene, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(-750, 50))
		unit_spawner.spawn_unit_lane(sorc_unit)
		
	if top_toggle:
		# Preload Sorceress scene
		var sorc_scene = preload(sorc_scene_path).instantiate()
		# Construct player Sorceress unit
		var sorc_unit = unit_spawner.spawn_unit(sorc_scene, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(-750, -100))
		unit_spawner.spawn_unit_lane(sorc_unit)
	if bot_toggle:
		# Preload Sorceress scene
		var sorc_scene = preload(sorc_scene_path).instantiate()
		# Construct player Sorceress unit
		var sorc_unit = unit_spawner.spawn_unit(sorc_scene, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(-750, 250))
		unit_spawner.spawn_unit_lane(sorc_unit)
	

func _set_toggled(MID_TOGGLE: bool, TOP_TOGGLE: bool, BOT_TOGGLE: bool) -> void:
	mid_toggle = MID_TOGGLE
	top_toggle = TOP_TOGGLE
	bot_toggle = BOT_TOGGLE
