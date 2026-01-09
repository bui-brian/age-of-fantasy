class_name UnitButton extends TextureButton

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

var spawn_button_cooldown: float = 2.0
var button_available: bool = true

func _ready() -> void:
	timer.timeout.connect(_reset_cooldown_timer)

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
