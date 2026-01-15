extends Node2D

@onready var player_tower_top: Tower = $PlayerTowerTop
@onready var player_tower_mid: Tower = $PlayerTowerMid
@onready var player_tower_bot: Tower = $PlayerTowerBot

@onready var enemy_tower_top: Tower = $EnemyTowerTop
@onready var enemy_tower_mid: Tower = $EnemyTowerMid
@onready var enemy_tower_bot: Tower = $EnemyTowerBot

@onready var title_screen: Control = %TitleScreen
@onready var end_screen: Control = %EndScreen

func _ready() -> void:
	player_tower_top.health.health_changed.connect(_set_player_health)
	player_tower_mid.health.health_changed.connect(_set_player_health)
	player_tower_bot.health.health_changed.connect(_set_player_health)
	
	enemy_tower_top.health.health_changed.connect(_set_enemy_health)
	enemy_tower_mid.health.health_changed.connect(_set_enemy_health)
	enemy_tower_bot.health.health_changed.connect(_set_enemy_health)

	GameState.global_health_depleted.connect(_on_global_health_depleted)

func _set_player_health(current_health):
	GameState.set_player_health(current_health)
	#player_tower_top.health.current_health = current_health
	#player_tower_mid.health.current_health = current_health
	#player_tower_bot.health.current_health = current_health

func _set_enemy_health(current_health):
	GameState.set_enemy_health(current_health)
	#enemy_tower_top.health.current_health = current_health
	#enemy_tower_mid.health.current_health = current_health
	#enemy_tower_bot.health.current_health = current_health

func _on_global_health_depleted() -> void:
	if not Tower:
		return
	
	if GameState.player_current_health <= 0:
		end_screen.label.text = "You lose!"
		end_screen.show() 
	if GameState.enemy_current_health <= 0:
		end_screen.label.text = "You win!"
		end_screen.show()
