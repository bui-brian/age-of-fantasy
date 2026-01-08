extends Node

@export var starting_state: UnitState
var current_state: UnitState

func init(parent: Unit) -> void:
	for child in get_children():
		child.parent = parent
	
	change_state(starting_state)

func change_state(new_state: UnitState) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

func _process(delta: float):
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)

func _physics_process(delta: float):
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
