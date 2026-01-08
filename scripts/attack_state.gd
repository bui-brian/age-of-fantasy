# attack_state.gd
extends UnitState

@export var move_state: UnitState
@export var idle_state: UnitState

func enter() -> void:
	parent.velocity.x = 0
	parent.hitbox.attacker_stats = parent.stats
	super()

func process_frame(delta: float):
	if not parent.attack_raycast.is_colliding():
		parent.state_machine.change_state(move_state)
