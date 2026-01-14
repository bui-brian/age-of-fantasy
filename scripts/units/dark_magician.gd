class_name DarkMagician extends Unit

func _ready():
	stats.base_damage = 40
	state_machine.init(self)
