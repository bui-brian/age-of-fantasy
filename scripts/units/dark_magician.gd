class_name DarkMagician extends Unit

func _ready():
	stats.base_damage = 25
	health.current_max_health = 120
	health_bar.max_value = health.current_max_health
	
	state_machine.init(self)
