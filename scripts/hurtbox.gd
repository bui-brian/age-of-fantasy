class_name Hurtbox extends Area2D

@onready var stats: Stats = owner.stats
#@onready var owner_ani_player = owner.get_node("AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monitoring = false

func receive_hit(damage: int) -> void:
	if not stats:
		return
		
	stats.health -= damage # health_changed or health_depleted signal emits
	print(stats.health)
	
	if stats.health <= 0:
		#owner_ani_player.set_current_animation("death")
		#await get_tree().create_timer(1.0).timeout
		#owner_health_bar.queue_free()
		owner.queue_free()
