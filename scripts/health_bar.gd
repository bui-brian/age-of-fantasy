extends ProgressBar

@export var health: Health

func _ready() -> void:
	health.health_changed.connect(_update_health)

# updates ProgressBar value every time Stats.health_changed signal emits
# current_health is passed in an argument
func _update_health(current_health):
	self.value = current_health
