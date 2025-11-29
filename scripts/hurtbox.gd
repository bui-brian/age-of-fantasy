class_name Hurtbox extends Area2D

@onready var owner_stats: Stats = owner.stats
#@onready var owner_ani_player = owner.get_node("AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monitoring = false

func receive_hit(damage: int) -> void:
	owner_stats.health -= damage
	print(owner_stats.health)
	if owner_stats.health <= 0:
		#owner_ani_player.set_current_animation("death")
		#await get_tree().create_timer(1.0).timeout
		owner.queue_free()
