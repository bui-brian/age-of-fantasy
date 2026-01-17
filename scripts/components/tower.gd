class_name Tower extends Node2D

signal lane_priority(attacked: bool)

@onready var hurtbox: Hurtbox = $Hurtbox
@onready var health: Health = $Health
@onready var health_bar: ProgressBar = $HealthBar
@onready var timer: Timer = $Timer

@export var faction: Util.Faction
var under_attack: bool = false

func _ready() -> void:
	health.current_max_health = 1000
	GameState.global_enemy_health_changed.connect(_on_tower_damaged)
	timer.wait_time = 2.0
	timer.timeout.connect(reset_attack_status)

func _on_tower_damaged(ENEMY_HEALTH) -> void:
	if under_attack:
		return
	
	under_attack = true
	lane_priority.emit(under_attack)
	timer.start()

func reset_attack_status() -> void:
	if not under_attack:
		return
	
	under_attack = false
	lane_priority.emit(under_attack)
