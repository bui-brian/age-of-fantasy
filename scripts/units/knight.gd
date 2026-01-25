class_name Knight extends Unit

func _ready():
	stats.base_damage = 20
	health.current_max_health = 220
	health_bar.max_value = health.current_max_health
	
	state_machine.init(self)
