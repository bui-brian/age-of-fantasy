extends Control

@onready var player_tower_mid_button: TextureButton = $PlayerTowerMidButton
@onready var player_tower_top_button: TextureButton = $PlayerTowerTopButton
@onready var player_tower_bot_button: TextureButton = $PlayerTowerBotButton

var locked: bool = false
var tween_intensity: float = 2.5
var tween_duration: float = 0.15
var MID_TOGGLE: bool = false
var TOP_TOGGLE: bool = false
var BOT_TOGGLE: bool = false

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
	if MID_TOGGLE:
		return
	player_tower_mid_button.modulate.a = 1.0
	start_tween(player_tower_mid_button, "scale", Vector2.ONE * tween_intensity, tween_duration)

func _on_top_hover_entered():
	if TOP_TOGGLE:
		return
	player_tower_top_button.modulate.a = 1.0
	start_tween(player_tower_top_button, "scale", Vector2.ONE * tween_intensity, tween_duration)

func _on_bot_hover_entered():
	if BOT_TOGGLE:
		return
	player_tower_bot_button.modulate.a = 1.0
	start_tween(player_tower_bot_button, "scale", Vector2.ONE * tween_intensity, tween_duration)

func _on_hover_exited():
	if MID_TOGGLE:
		return
	else:
		start_tween(player_tower_mid_button, "scale", Vector2.ONE, tween_duration)
		player_tower_mid_button.modulate.a = 0.0
	
	if TOP_TOGGLE:
		return
	else:
		start_tween(player_tower_top_button, "scale", Vector2.ONE, tween_duration)
		player_tower_top_button.modulate.a = 0.0
	
	if BOT_TOGGLE:
		return
	else:
		start_tween(player_tower_bot_button, "scale", Vector2.ONE, tween_duration)
		player_tower_bot_button.modulate.a = 0.0

func _on_player_tower_mid_pressed():
	# Toggle locked state
	MID_TOGGLE = !MID_TOGGLE
	player_tower_mid_button.modulate.a = 1.0 if MID_TOGGLE else 0.0
	player_tower_mid_button.scale = Vector2.ONE * (tween_intensity if MID_TOGGLE else 1)

func _on_player_tower_top_pressed():
	TOP_TOGGLE = !TOP_TOGGLE
	player_tower_top_button.modulate.a = 1.0 if TOP_TOGGLE else 0.0
	player_tower_top_button.scale = Vector2.ONE * (tween_intensity if TOP_TOGGLE else 1)

func _on_player_tower_bot_pressed():
	BOT_TOGGLE = !BOT_TOGGLE
	player_tower_bot_button.modulate.a = 1.0 if BOT_TOGGLE else 0.0
	player_tower_bot_button.scale = Vector2.ONE * (tween_intensity if BOT_TOGGLE else 1)

func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)
