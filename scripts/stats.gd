class_name Stats extends Resource

const BASE_LEVEL_XP: float = 100.0

signal health_depleted
signal health_changed(cur_health: int, max_health: int)

@export var base_max_health: int = 100
@export var base_defense: int = 10
@export var base_attack: int = 10
@export var base_damage: int = 2

var current_max_health: int = 100
var current_defense: int = 10
var current_attack: int = 10

var health: int = 0: set = _on_health_set
var speed : float = 50.0

func _init() -> void:
	setup_stats.call_deferred()

func setup_stats() -> void:
	health = current_max_health

func _on_health_set(new_value: int) -> void:
	health = clampi(new_value, 0, current_max_health)
	health_changed.emit(health, current_max_health)
	if health <= 0:
		health_depleted.emit()
