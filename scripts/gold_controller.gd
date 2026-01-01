# economy_controller.gd
# Gold Controller
extends Node2D

@onready var gold_timer: Timer = $GoldTimer
@onready var sorc_spawner: UnitSpawner = $"../UnitSpawner"
@onready var enemy_controller: Node2D = $"../EnemyController"

var player_gold: int = 0
var enemy_gold: int = 0
var gold_per_tick: int = 5
var gold_tick_rate: float = 0.5

func _ready():
	gold_timer.wait_time = gold_tick_rate
	gold_timer.timeout.connect(gold_tick)
	gold_timer.start()
	
	sorc_spawner.gold_spent.connect(_on_gold_spent)
	enemy_controller.enemy_gold_spent.connect(_on_enemy_gold_spent)

func gold_tick():
	player_gold += gold_per_tick
	enemy_gold += gold_per_tick
	GameState.set_gold(player_gold, enemy_gold)
	print("Player gold: ", player_gold)
	print("Enemy gold: ", enemy_gold)

func _on_gold_spent(gold_amount):
	player_gold -= gold_amount
	if player_gold <= 0:
		player_gold = 0
	GameState.set_gold(player_gold, enemy_gold)

func _on_enemy_gold_spent(subtract_gold):
	enemy_gold -= subtract_gold
	if enemy_gold <= 0:
		enemy_gold = 0
	GameState.set_gold(player_gold, enemy_gold)
