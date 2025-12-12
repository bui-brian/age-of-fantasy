class_name Unit extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var hitbox: Hitbox = $Hitbox
@onready var health_bar: ProgressBar = $HealthBar

enum Faction {
	PLAYER,
	ENEMY,
}

var faction: Faction
var stats : Stats = Stats.new()
var direction := 0 # 1 = right, -1 = left

func _ready():
	# placeholder: initialize stats when needed
	stats.base_damage = 20
	set_fill_mode.call_deferred()

func _process(delta):
	raycast_detection()

func set_fill_mode() -> void:
	if direction >= 0:
		health_bar.fill_mode = ProgressBar.FILL_BEGIN_TO_END
	elif direction < 0:
		health_bar.fill_mode = ProgressBar.FILL_END_TO_BEGIN

func raycast_detection():
	if not ray_cast_2d.is_colliding():
		stats.speed = 50
		animation_player.set_current_animation("run")
	else:
		var unit_check = ray_cast_2d.get_collider()
		if !unit_check:
			return
		# match depending on the faction
		match self.faction:
			Faction.PLAYER: # if you are the player, attack the enemy and stop for friendly
				match unit_check.faction:
					Faction.PLAYER: # if collider is player, stop
						stats.speed = 0
						animation_player.set_current_animation("idle")

					Faction.ENEMY: # if collider is enemy, attack
						stats.speed = 0
						animation_player.set_current_animation("attack1")
						hitbox.attacker_stats = stats
	

			Faction.ENEMY: # if you are the enemy, attack the player and stop for enemy
				match unit_check.faction:
					Faction.PLAYER: #  if collider is player, player
						stats.speed = 0
						animation_player.set_current_animation("attack1")
						hitbox.attacker_stats = stats

					Faction.ENEMY: # if collider is enemy, stop
						stats.speed = 0
						animation_player.set_current_animation("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = direction * stats.speed
	move_and_slide()
