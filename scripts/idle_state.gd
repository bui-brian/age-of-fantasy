# idle_state.gd
extends UnitState

@export var move_state: UnitState
@export var attack_state: UnitState

func enter() -> void:
	super()
	parent.velocity.x = 0

func process_frame(delta: float):
	friendly_detection()

func friendly_detection() -> void:
	if not parent.friendly_raycast.is_colliding():
		parent.state_machine.change_state(move_state)
