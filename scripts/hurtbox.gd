class_name Hurtbox extends Area2D

#@onready var stats: Stats = owner.stats
@export var health: Health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monitoring = false

func receive_hit(damage: int) -> void:
	if not health:
		return
		
	health.current_health -= damage # health_changed or health_depleted signal emits
