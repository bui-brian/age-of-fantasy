extends Control

@onready var player_tower_mid_button: TextureButton = $PlayerTowerMidButton

var locked: bool = false
var tween_intensity: float = 2.0
var tween_duration: float = 0.15

func _ready() -> void:
	player_tower_mid_button.modulate.a = 0.0
	player_tower_mid_button.pivot_offset = player_tower_mid_button.size / 2
	player_tower_mid_button.mouse_filter = Control.MOUSE_FILTER_STOP

	# Connect signals
	player_tower_mid_button.mouse_entered.connect(_on_hover_entered)
	player_tower_mid_button.mouse_exited.connect(_on_hover_exited)
	player_tower_mid_button.pressed.connect(_on_button_pressed)

func _on_hover_entered():
	if locked:
		return
	player_tower_mid_button.modulate.a = 1.0
	start_tween(player_tower_mid_button, "scale", Vector2.ONE * tween_intensity, tween_duration)

func _on_hover_exited():
	if locked:
		return
	start_tween(player_tower_mid_button, "scale", Vector2.ONE, tween_duration)
	player_tower_mid_button.modulate.a = 0.0

func _on_button_pressed():
	# Toggle locked state
	locked = !locked
	player_tower_mid_button.modulate.a = 1.0 if locked else 0.0
	player_tower_mid_button.scale = Vector2.ONE * (tween_intensity if locked else 1)
	print("Button clicked! Locked =", locked)

func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)
