class_name UnitButton extends TextureButton

signal unit_button_pressed(gold_cost, scene_str, button_available)

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

var spawn_button_cooldown: float = 1.5
var button_available: bool = true
var gold_cost: int = 50
var unit_scene: String = ""

func _ready() -> void:
	timer.timeout.connect(_reset_cooldown_timer)
	pressed.connect(_on_pressed)

func set_cooldown_timer() -> void:
	if !button_available:
		return
	
	button_available = false
	timer.one_shot = true
	timer.wait_time = spawn_button_cooldown
	print("Start timer...")
	timer.start()

func _reset_cooldown_timer() -> void:
	if button_available:
		return
	button_available = true
	print("...Timer reset")

func _on_pressed() -> void:
	if GameState.player_gold <= gold_cost:
		return
	unit_button_pressed.emit(gold_cost, unit_scene, button_available)
	set_cooldown_timer()
