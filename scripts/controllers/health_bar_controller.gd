# health_bar_controller.gd
extends Control

@onready var player_health_bar: TextureProgressBar = $PlayerHealthBar
@onready var enemy_health_bar: TextureProgressBar = $EnemyHealthBar

func _ready() -> void:
	GameState.global_player_health_changed.connect(_on_global_player_health_changed)
	GameState.global_enemy_health_changed.connect(_on_global_enemy_health_changed)

func _on_global_player_health_changed(PLAYER_HEALTH):
	player_health_bar.value = PLAYER_HEALTH

func _on_global_enemy_health_changed(ENEMY_HEALTH):
	enemy_health_bar.value = ENEMY_HEALTH
