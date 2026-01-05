extends ProgressBar

#@onready var stats: Stats = owner.stats
@export var health: Health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.scale.x = 1
	health.health_changed.connect(_update_health)

# updates ProgressBar value every time Stats.health_changed signal emits
# health, max_health are passed in as arguments
func _update_health(health, max_health):
	self.value = health
