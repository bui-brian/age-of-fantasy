class_name Hurtbox extends Area2D

@onready var owner_stats: Stats = owner.stats
@onready var owner_health_bar: ProgressBar = owner.health_bar
#@onready var owner_ani_player = owner.get_node("AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monitoring = false

func receive_hit(damage: int) -> void:
	if not owner_stats:
		return
		
	owner_stats.health -= damage
	print(owner_stats.health)
	
	if owner_stats.health <= 0:
		#owner_ani_player.set_current_animation("death")
		#await get_tree().create_timer(1.0).timeout
		#owner_health_bar.queue_free()
		owner.queue_free()
	else:
		owner_stats.health_changed.emit(owner_stats.health, owner_stats.base_max_health)
		#owner_health_bar.update_health()
