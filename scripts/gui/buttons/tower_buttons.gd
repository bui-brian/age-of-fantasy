class_name TowerButtons extends Control

@onready var player_tower_mid_button: TextureButton = $PlayerTowerMidButton
@onready var player_tower_top_button: TextureButton = $PlayerTowerTopButton
@onready var player_tower_bot_button: TextureButton = $PlayerTowerBotButton

signal toggled(
	MID_TOGGLE: bool,
	TOP_TOGGLE: bool,
	BOT_TOGGLE: bool,
)

var mid_toggle: bool = false
var top_toggle: bool = false
var bot_toggle: bool = false

var tween_intensity: float = 2.5
var tween_duration: float = 0.15

func _ready() -> void:
	player_tower_mid_button.modulate.a = 0.0
	player_tower_mid_button.pivot_offset = player_tower_mid_button.size / 2
	player_tower_mid_button.mouse_filter = Control.MOUSE_FILTER_STOP
	
	player_tower_top_button.modulate.a = 0.0
	player_tower_top_button.pivot_offset = player_tower_mid_button.size / 2
	player_tower_top_button.mouse_filter = Control.MOUSE_FILTER_STOP
	
	player_tower_bot_button.modulate.a = 0.0
	player_tower_bot_button.pivot_offset = player_tower_mid_button.size / 2
	player_tower_bot_button.mouse_filter = Control.MOUSE_FILTER_STOP

	# Connect signals
	player_tower_mid_button.mouse_entered.connect(_on_mid_hover_entered)
	player_tower_mid_button.mouse_exited.connect(_on_hover_exited)
	player_tower_mid_button.pressed.connect(_on_player_tower_mid_pressed)
	
	player_tower_top_button.mouse_entered.connect(_on_top_hover_entered)
	player_tower_top_button.mouse_exited.connect(_on_hover_exited)
	player_tower_top_button.pressed.connect(_on_player_tower_top_pressed)
	
	player_tower_bot_button.mouse_entered.connect(_on_bot_hover_entered)
	player_tower_bot_button.mouse_exited.connect(_on_hover_exited)
	player_tower_bot_button.pressed.connect(_on_player_tower_bot_pressed)

func _on_mid_hover_entered():
	if mid_toggle:
		return
	player_tower_mid_button.modulate.a = 1.0
	start_tween(player_tower_mid_button, "scale", Vector2.ONE * tween_intensity, tween_duration)

func _on_top_hover_entered():
	if top_toggle:
		return
	player_tower_top_button.modulate.a = 1.0
	start_tween(player_tower_top_button, "scale", Vector2.ONE * tween_intensity, tween_duration)

func _on_bot_hover_entered():
	if bot_toggle:
		return
	player_tower_bot_button.modulate.a = 1.0
	start_tween(player_tower_bot_button, "scale", Vector2.ONE * tween_intensity, tween_duration)

func _on_hover_exited():
	if mid_toggle:
		return
	else:
		start_tween(player_tower_mid_button, "scale", Vector2.ONE, tween_duration)
		player_tower_mid_button.modulate.a = 0.0
	
	if top_toggle:
		return
	else:
		start_tween(player_tower_top_button, "scale", Vector2.ONE, tween_duration)
		player_tower_top_button.modulate.a = 0.0
	
	if bot_toggle:
		return
	else:
		start_tween(player_tower_bot_button, "scale", Vector2.ONE, tween_duration)
		player_tower_bot_button.modulate.a = 0.0

func _on_player_tower_mid_pressed():
	mid_toggle = !mid_toggle
	
	if mid_toggle:
		player_tower_mid_button.modulate.a = 1.0
		player_tower_mid_button.scale = Vector2.ONE * tween_intensity
	else:
		player_tower_mid_button.modulate.a = 0.0
		player_tower_mid_button.scale = Vector2.ONE * 1
	
	toggled.emit(mid_toggle, top_toggle, bot_toggle)

func _on_player_tower_top_pressed():
	top_toggle = !top_toggle
	
	if top_toggle:
		player_tower_top_button.modulate.a = 1.0
		player_tower_top_button.scale = Vector2.ONE * tween_intensity
	else:
		player_tower_top_button.modulate.a = 0.0
		player_tower_top_button.scale = Vector2.ONE * 1
	
	toggled.emit(mid_toggle, top_toggle, bot_toggle)

func _on_player_tower_bot_pressed():
	bot_toggle = !bot_toggle
	
	if bot_toggle:
		player_tower_bot_button.modulate.a = 1.0
		player_tower_bot_button.scale = Vector2.ONE * tween_intensity
	else:
		player_tower_bot_button.modulate.a = 0.0
		player_tower_bot_button.scale = Vector2.ONE * 1
	
	toggled.emit(mid_toggle, top_toggle, bot_toggle)

func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)
