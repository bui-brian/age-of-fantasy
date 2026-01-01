extends TextureButton

@onready var unit_spawner: UnitSpawner = $"../../../../UnitSpawner"
@onready var tower_buttons: Control = $"../../../TowerButtons"
@onready var timer: Timer = $Timer

signal player_gold_spent(gold_spent)

const sorc_scene_path = "res://scenes/units/lightning_sorc.tscn"

var mid_toggle: bool = false
var top_toggle: bool = false
var bot_toggle: bool = false

var spawn_button_cooldown: float = 2.0
var button_available: bool = true

func _ready() -> void:
	self.pressed.connect(_sorceress_button_pressed)
	tower_buttons.toggled.connect(_set_toggled)
	timer.timeout.connect(_reset_cooldown_timer)

# --- Button handlers ---
func _set_toggled(MID_TOGGLE: bool, TOP_TOGGLE: bool, BOT_TOGGLE: bool) -> void:
	mid_toggle = MID_TOGGLE
	top_toggle = TOP_TOGGLE
	bot_toggle = BOT_TOGGLE

func set_cooldown_timer() -> void:
	if !button_available:
		return
	
	button_available = false
	timer.one_shot = true
	timer.wait_time = spawn_button_cooldown
	timer.start()

func _reset_cooldown_timer() -> void:
	if button_available:
		return
	button_available = true

func _sorceress_button_pressed() -> void:
	if !button_available:
		return
	
	set_cooldown_timer()

	# If toggles are on, spawn in respective lane
	if top_toggle:
		# Preload Sorceress scene
		var sorc_scene = preload(sorc_scene_path).instantiate()
		# Construct player Sorceress unit
		var sorc_unit = unit_spawner.spawn_unit(sorc_scene, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(-750, -100), Unit.UnitLane.TOP)
		unit_spawner.spawn_unit_lane(sorc_unit)
		GameState.set_player_count(GameState.player_unit_count_mid, GameState.player_unit_count_top+1, GameState.player_unit_count_bot)
		player_gold_spent.emit(50)
	if mid_toggle:
		# Preload Sorceress scene
		var sorc_scene = preload(sorc_scene_path).instantiate()
		# Construct player Sorceress unit
		var sorc_unit = unit_spawner.spawn_unit(sorc_scene, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(-750, 50), Unit.UnitLane.MID)
		unit_spawner.spawn_unit_lane(sorc_unit)
		GameState.set_player_count(GameState.player_unit_count_mid+1, GameState.player_unit_count_top, GameState.player_unit_count_bot)
		player_gold_spent.emit(50)
	if bot_toggle:
		# Preload Sorceress scene
		var sorc_scene = preload(sorc_scene_path).instantiate()
		# Construct player Sorceress unit
		var sorc_unit = unit_spawner.spawn_unit(sorc_scene, Unit.Faction.PLAYER, Vector2.RIGHT, Vector2(-750, 250), Unit.UnitLane.BOT)
		unit_spawner.spawn_unit_lane(sorc_unit)
		GameState.set_player_count(GameState.player_unit_count_mid, GameState.player_unit_count_top, GameState.player_unit_count_bot+1)
		player_gold_spent.emit(50)
