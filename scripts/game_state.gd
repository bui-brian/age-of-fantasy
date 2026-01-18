# game_state.gd
extends Node

signal global_gold_changed(player_gold, enemy_gold)

signal global_player_health_changed(player_health)
signal global_enemy_health_changed(enemy_health)

signal global_health_depleted

var player_total_health: int = 1000
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
	call_deferred("set_gold", 0, 0)
	#await get_tree().process_frame
	#set_gold(0,0)

func set_player_health(PLAYER_HEALTH):
	if player_total_health == PLAYER_HEALTH:
		return
	
	player_total_health = PLAYER_HEALTH
	global_player_health_changed.emit(player_total_health)
	
	if player_total_health <= 0:
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

func set_player_count_top(PLAYER_UNIT_COUNT_TOP):
	if PLAYER_UNIT_COUNT_TOP <= 0:
		player_unit_count_top = 0
		return
	
	player_unit_count_top = PLAYER_UNIT_COUNT_TOP

func set_player_count_mid(PLAYER_UNIT_COUNT_MID):
	if PLAYER_UNIT_COUNT_MID <= 0:
		player_unit_count_mid = 0
		return
	
	player_unit_count_mid = PLAYER_UNIT_COUNT_MID

func set_player_count_bot(PLAYER_UNIT_COUNT_BOT):
	if PLAYER_UNIT_COUNT_BOT <= 0:
		player_unit_count_bot = 0
		return
	
	player_unit_count_bot = PLAYER_UNIT_COUNT_BOT

func set_enemy_count_top(ENEMY_UNIT_COUNT_TOP):
	if ENEMY_UNIT_COUNT_TOP <= 0:
		enemy_unit_count_top = 0
		return
	
	enemy_unit_count_top = ENEMY_UNIT_COUNT_TOP

func set_enemy_count_mid(ENEMY_UNIT_COUNT_MID):
	if ENEMY_UNIT_COUNT_MID <= 0:
		enemy_unit_count_mid = 0
		return
	
	enemy_unit_count_mid = ENEMY_UNIT_COUNT_MID

func set_enemy_count_bot(ENEMY_UNIT_COUNT_BOT):
	if ENEMY_UNIT_COUNT_BOT <= 0:
		enemy_unit_count_bot = 0
		return
	
	enemy_unit_count_bot = ENEMY_UNIT_COUNT_BOT
