# health_bar_controller.gd
extends Control

@onready var player_health_bar: TextureProgressBar = $PlayerHealthBar
@onready var enemy_health_bar: TextureProgressBar = $EnemyHealthBar

func _ready() -> void:
	GameState.global_health_changed.connect(_on_global_health_changed)

func _on_global_health_changed(player_health, enemy_health):
	player_health_bar.value = player_health
	enemy_health_bar.value = enemy_health
