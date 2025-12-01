class_name Unit extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var hitbox: Hitbox = $Hitbox

enum Faction {
	PLAYER,
	ENEMY,
}

var stats : Stats = Stats.new()
var direction := 0 # 1 = right, -1 = left

func _ready():
	# placeholder: initialize stats when needed
	pass

func raycast_detection():
	if not ray_cast_2d.is_colliding():
		stats.speed = 50
		animation_player.set_current_animation("run")
	else:
		var unit_check = ray_cast_2d.get_collider()
		if !unit_check:
			return
		# add match - switch statement here depending on the faction
		elif unit_check.Faction.ENEMY: # detect and attack enemy
			stats.speed = 0
			animation_player.set_current_animation("attack1")
			hitbox.attacker_stats = stats
		elif unit_check.Faction.PLAYER and unit_check.stats.speed <= 0: # detect friendly
			stats.speed = 0
			animation_player.set_current_animation("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	raycast_detection()
	
	velocity.x = direction * stats.speed
	move_and_slide()
