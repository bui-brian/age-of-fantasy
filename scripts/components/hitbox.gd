class_name Hitbox extends Area2D

var attacker_stats: Stats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monitorable = false
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if not area.has_method("receive_hit") or not attacker_stats or area == owner.hurtbox:
		return
	
	area.receive_hit(attacker_stats.base_damage)
	area.tower_hit(attacker_stats.base_damage)
