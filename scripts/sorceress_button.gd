extends TextureButton

@onready var sorc_spawner: UnitSpawner = $"../../../../UnitSpawner"

func _ready() -> void:
	self.pressed.connect(_sorceress_button_pressed)

# --- Button handlers ---
func _sorceress_button_pressed() -> void:
	sorc_spawner.spawn_unit_lane()
