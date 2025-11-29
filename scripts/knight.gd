extends CharacterBody2D

@onready var ray_cast_forward: RayCast2D = $RayCast2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Hitbox = $Hitbox

var stats: Stats = Stats.new()
var speed := 50
var direction := 0

func _ready():
	stats.base_damage = 20

func _process(delta):
	pass
	#if stats.current_max_health <= 0:
		#animation_player.set_current_animation("death")
		# timeout until node is removed
		# free node
		#self.queue.free()

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
		if unit_check.is_in_group("player"):
			speed = 0
			animation_player.set_current_animation("attack1")
			hitbox.attacker_stats = stats
		elif unit_check.is_in_group("enemy") and unit_check.speed <= 0:
			speed = 0
			animation_player.set_current_animation("idle")
	else:
		animation_player.set_current_animation("run")
		speed = 50
