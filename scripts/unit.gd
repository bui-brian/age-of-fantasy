# unit.gd
class_name Unit extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_body: CollisionShape2D = $CollisionBody
@onready var attack_raycast: RayCast2D = $AttackRaycast
@onready var friendly_raycast: RayCast2D = $FriendlyRaycast
@onready var hitbox: Hitbox = $Hitbox
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var health: Health = $Health
@onready var health_bar: ProgressBar = $HealthBar
@onready var state_machine: Node = $state_machine

enum Faction {
	PLAYER,
	ENEMY,
}

enum UnitLane {
	TOP,
	MID,
	BOT
}

var faction: Faction
var stats: Stats = Stats.new()
var direction := 0 # 1 = right, -1 = left
var current_lane: UnitLane

func _ready() -> void:
	set_fill_mode.call_deferred()

func set_fill_mode() -> void:
	if direction >= 0:
		health_bar.fill_mode = ProgressBar.FILL_BEGIN_TO_END
	elif direction < 0:
		health_bar.fill_mode = ProgressBar.FILL_END_TO_BEGIN
