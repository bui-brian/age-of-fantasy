class_name Unit extends CharacterBody2D

enum Faction {
	PLAYER,
	ENEMY,
}

var direction := 0
var speed := 50

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	raycast_detection()
	
	velocity.x = direction * speed
	move_and_slide()

func raycast_detection():
	pass
