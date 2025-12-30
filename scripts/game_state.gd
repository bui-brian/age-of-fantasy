extends Node2D

#@onready var unit_spawner: UnitSpawner = $UnitSpawner

signal state_changed(new_state: GameState)

var current_state: GameState

var player_gold: int = 0
var enemy_gold: int = 0

var current_player_unit_count_mid: int = 0
var current_player_unit_count_top: int = 0
var current_player_unit_count_bot: int = 0

var enemy_unit_count_mid: int = 0
var enemy_unit_count_top: int = 0
var enemy_unit_count_bot: int = 0

#func _ready():
	#unit_spawner.player_unit_count.connect(_update_state)
#
#func _update_state(player_unit_count_mid, player_unit_count_top, player_unit_count_bot):
	#current_player_unit_count_mid = player_unit_count_mid
	#current_player_unit_count_mid = player_unit_count_top
	#current_player_unit_count_mid = player_unit_count_bot

func set_state(new_state: GameState):
	if current_state == new_state:
		return
	current_state = new_state
	state_changed.emit(new_state)

func set_gold(PLAYER_GOLD, ENEMY_GOLD):
	player_gold = PLAYER_GOLD
	enemy_gold = ENEMY_GOLD
	state_changed.emit(self)

func set_player_count(player_unit_count_mid, player_unit_count_top, player_unit_count_bot):
	current_player_unit_count_mid = player_unit_count_mid
	current_player_unit_count_top = player_unit_count_top
	current_player_unit_count_bot = player_unit_count_bot
