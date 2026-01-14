class_name Knight extends Unit

func _ready():
	stats.base_damage = 30
	state_machine.init(self)
