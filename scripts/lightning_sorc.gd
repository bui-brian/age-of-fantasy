class_name LM extends Unit

func _ready():
	stats.base_damage = 40

#func raycast_detection():
	#if ray_cast_forward.is_colliding():
		#var unit_check = ray_cast_forward.get_collider()
		#if !unit_check:
			#return
		#if unit_check.is_in_group("player"):
			#stats.speed = 0
			#animation_player.set_current_animation("attack1")
			#hitbox.attacker_stats = stats
		#elif unit_check.is_in_group("enemy") and unit_check.stats.speed <= 0:
			#stats.speed = 0
			#animation_player.set_current_animation("idle")
	#else:
		#animation_player.set_current_animation("run")
		#stats.speed = 50
