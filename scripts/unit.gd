# unit.gd
class_name Unit extends CharacterBody2D

@onready var state_machine: Node = $state_machine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var attack_raycast: RayCast2D = $AttackRaycast
@onready var friendly_raycast: RayCast2D = $FriendlyRaycast
@onready var hitbox: Hitbox = $Hitbox
@onready var health_bar: ProgressBar = $HealthBar

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
