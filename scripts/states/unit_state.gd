class_name UnitState
extends Node

@export var animation_name: String
@export var move_speed: float = 0.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var parent: Unit

func enter() -> void:
	parent.animation_player.play(animation_name)

func exit() -> void:
	parent.animation_player.stop()

func process_frame(delta: float):
	pass
	
func process_physics(delta: float):
	if not parent.is_on_floor():
		#parent.velocity += parent.get_gravity() * delta
		parent.velocity.y += gravity * delta
	parent.velocity.x = parent.direction * move_speed
	parent.move_and_slide()
