# game_state.gd
extends Node2D

signal state_changed(new_state: GameState)

var current_state: GameState

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
	state_changed.emit(new_state)

func set_gold(PLAYER_GOLD, ENEMY_GOLD):
	player_gold = PLAYER_GOLD
	enemy_gold = ENEMY_GOLD
	state_changed.emit(self)

func set_player_count(PLAYER_UNIT_COUNT_MID, PLAYER_UNIT_COUNT_TOP, PLAYER_UNIT_COUNT_BOT):
	player_unit_count_top = PLAYER_UNIT_COUNT_TOP
	player_unit_count_mid = PLAYER_UNIT_COUNT_MID
	player_unit_count_bot = PLAYER_UNIT_COUNT_BOT
