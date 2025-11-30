extends CharacterBody2D

@onready var ray_cast_forward: RayCast2D = $RayCast2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Hitbox = $Hitbox

var stats: Stats = Stats.new()
var direction := 0

func _ready():
	stats.base_damage = 20

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	raycast_detection()
	
	velocity.x = direction * stats.speed
	move_and_slide()

func raycast_detection():
	if ray_cast_forward.is_colliding():
		var unit_check = ray_cast_forward.get_collider()
		if !unit_check:
			return
		if unit_check.is_in_group("enemy"):
			stats.speed = 0
			animation_player.set_current_animation("attack1")
			hitbox.attacker_stats = stats
		elif unit_check.is_in_group("player") and unit_check.stats.speed <= 0:
			stats.speed = 0
			animation_player.set_current_animation("idle")
	else:
		stats.speed = 50
		animation_player.set_current_animation("run")
