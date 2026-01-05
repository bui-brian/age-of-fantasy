class_name Hurtbox extends Area2D

@export var health: Health

func receive_hit(damage: int) -> void:
	if not health:
		return
	
	health.current_health -= damage # health_changed or health_depleted signal emits
