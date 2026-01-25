class_name LM extends Unit

func _ready():
	stats.base_damage = 60
	health.current_max_health = 100
	health_bar.max_value = health.current_max_health
	
	state_machine.init(self)
