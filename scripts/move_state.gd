# move_state.gd
extends UnitState

@export var attack_state: UnitState
@export var idle_state: UnitState

var hurtbox_check
var friendly_check

func enter() -> void:
	move_speed = 50
	super()

func process_frame(delta: float):
	attack_detection()
	friendly_detection()

func friendly_detection() -> void:
	if not parent.friendly_raycast.is_colliding():
		return
		
	friendly_check = parent.friendly_raycast.get_collider()
	
	if !friendly_check:
		return
	
	if parent.faction == friendly_check.faction:
		parent.state_machine.change_state(idle_state)

func attack_detection() -> void:
	if parent.attack_raycast.is_colliding():
		hurtbox_check = parent.attack_raycast.get_collider()
	
	if !hurtbox_check:
		return
	
	# match self depending on the faction
	match parent.faction:
		Unit.Faction.PLAYER:
			if hurtbox_check.owner.faction == Unit.Faction.ENEMY:
				parent.velocity.x = 0
				parent.state_machine.change_state(attack_state)
		Unit.Faction.ENEMY:
			if hurtbox_check.owner.faction == Unit.Faction.PLAYER:
				parent.velocity.x = 0
				parent.state_machine.change_state(attack_state)
