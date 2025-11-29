extends CharacterBody2D

@onready var ray_cast_forward: RayCast2D = $RayCast2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Hitbox = $Hitbox

var stats: Stats = Stats.new()
var speed := 50.0
var direction := 0

func _ready():
	stats.base_damage = 20

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	raycast_detection()
	
	velocity.x = direction * speed
	move_and_slide()

func raycast_detection():
	if ray_cast_forward.is_colliding():
		var unit_check = ray_cast_forward.get_collider()
		if !unit_check:
			return
		elif unit_check.is_in_group("enemy"):
			speed = 0
			animation_player.set_current_animation("attack1")
			hitbox.attacker_stats = stats
		elif unit_check.is_in_group("player") and unit_check.speed <= 0:
			# if unit in front of them has speed = 0
			# then stop animation/play idle animation and set speed = 0
			speed = 0
			animation_player.set_current_animation("idle")
	else:
		speed = 50
		animation_player.set_current_animation("run")
