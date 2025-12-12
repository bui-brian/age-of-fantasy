extends ProgressBar

@onready var stats: Stats = owner.stats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stats.health_changed.connect(update_health)

func _process(delta):
	self.scale.x = 1

# updates ProgressBar value every time Stats.health_changed signal emits
# health, max_health are passed in as arguments
func update_health(health, max_health):
	value = health
