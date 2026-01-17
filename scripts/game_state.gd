# game_state.gd
extends Node

signal global_gold_changed(player_gold, enemy_gold)

signal global_player_health_changed(player_health)
signal global_enemy_health_changed(enemy_health)

signal global_health_depleted

var player_current_health: int = 1000
var enemy_total_health: int = 1000

var player_gold: int = 0
var enemy_gold: int = 0

var player_unit_count_mid: int = 0
var player_unit_count_top: int = 0
var player_unit_count_bot: int = 0

var enemy_unit_count_mid: int = 0
var enemy_unit_count_top: int = 0
var enemy_unit_count_bot: int = 0

func _ready() -> void:
	set_player_health(1000)
	set_enemy_health(1000)
	#await get_tree().process_frame
	#set_gold(0,0)
	#set_player_count(0,0,0)
	#set_enemy_count(0,0,0)
	call_deferred("set_gold", 0, 0)
	call_deferred("set_player_count", 0, 0, 0)
	call_deferred("set_enemy_count", 0, 0, 0)

func set_player_health(PLAYER_HEALTH):
	if player_current_health == PLAYER_HEALTH:
		return
	
	player_current_health = PLAYER_HEALTH
	global_player_health_changed.emit(player_current_health)
	
	if player_current_health <= 0:
		global_health_depleted.emit()

func set_enemy_health(ENEMY_HEALTH):
	if enemy_total_health == ENEMY_HEALTH:
		return
	
	enemy_total_health = ENEMY_HEALTH
	global_enemy_health_changed.emit(enemy_total_health)
	
	if enemy_total_health <= 0:
		global_health_depleted.emit()

func set_gold(PLAYER_GOLD, ENEMY_GOLD):
	player_gold = PLAYER_GOLD
	enemy_gold = ENEMY_GOLD
	global_gold_changed.emit(player_gold, enemy_gold)

func set_player_count(PLAYER_UNIT_COUNT_MID, PLAYER_UNIT_COUNT_TOP, PLAYER_UNIT_COUNT_BOT):
	player_unit_count_top = PLAYER_UNIT_COUNT_TOP
	player_unit_count_mid = PLAYER_UNIT_COUNT_MID
	player_unit_count_bot = PLAYER_UNIT_COUNT_BOT

func set_enemy_count(ENEMY_UNIT_COUNT_TOP, ENEMY_UNIT_COUNT_MID, ENEMY_UNIT_COUNT_BOT):
	enemy_unit_count_top = ENEMY_UNIT_COUNT_TOP
	enemy_unit_count_mid = ENEMY_UNIT_COUNT_MID
	enemy_unit_count_bot = ENEMY_UNIT_COUNT_BOT
