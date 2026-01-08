# game_state.gd
extends Node2D

signal state_changed(new_state: GameState)
signal global_health_changed(player_health, enemy_health)

var current_state: GameState

var player_current_health: int = 0
var enemy_current_health: int = 0

var player_gold: int = 0
var enemy_gold: int = 0

var player_unit_count_mid: int = 0
var player_unit_count_top: int = 0
var player_unit_count_bot: int = 0

var enemy_unit_count_mid: int = 0
var enemy_unit_count_top: int = 0
var enemy_unit_count_bot: int = 0

func set_state(new_state: GameState):
	if current_state == new_state:
		return
	current_state = new_state
	state_changed.emit(current_state)

func set_player_health(PLAYER_HEALTH):
	player_current_health = PLAYER_HEALTH
	state_changed.emit(self)
	global_health_changed.emit(player_current_health, enemy_current_health)

func set_enemy_health(ENEMY_HEALTH):
	enemy_current_health = ENEMY_HEALTH
	state_changed.emit(self)
	global_health_changed.emit(player_current_health, enemy_current_health)

func set_gold(PLAYER_GOLD, ENEMY_GOLD):
	player_gold = PLAYER_GOLD
	enemy_gold = ENEMY_GOLD
	state_changed.emit(self)

func set_player_count(PLAYER_UNIT_COUNT_MID, PLAYER_UNIT_COUNT_TOP, PLAYER_UNIT_COUNT_BOT):
	player_unit_count_top = PLAYER_UNIT_COUNT_TOP
	player_unit_count_mid = PLAYER_UNIT_COUNT_MID
	player_unit_count_bot = PLAYER_UNIT_COUNT_BOT
