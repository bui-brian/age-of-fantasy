extends ProgressBar

@onready var unit_stats: Stats = owner.stats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	unit_stats.health_changed.connect(update_health)

func update_health(health, max_health):
	value = health
