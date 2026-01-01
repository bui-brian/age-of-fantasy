# gold_controller.gd
extends Node2D

@onready var gold_timer: Timer = $GoldTimer
@onready var enemy_controller: Node2D = $"../EnemyController"
@onready var sorceress_button: TextureButton = $"../UI/SideBar/VBoxContainer/SorceressButton"

var player_gold: int = 0
var enemy_gold: int = 0
var gold_per_tick: int = 15
var gold_tick_rate: float = 1.0

func _ready():
	sorceress_button.player_gold_spent.connect(_on_player_gold_spent)
	enemy_controller.enemy_gold_spent.connect(_on_enemy_gold_spent)
	
	gold_timer.wait_time = gold_tick_rate
	gold_timer.timeout.connect(gold_tick)
	gold_timer.start()

func gold_tick():
	player_gold += gold_per_tick
	enemy_gold += gold_per_tick
	GameState.set_gold(player_gold, enemy_gold)
	print("Player gold: ", player_gold)
	print("Enemy gold: ", enemy_gold)

func _on_player_gold_spent(gold_spent):
	player_gold -= gold_spent
	if player_gold <= 0:
		player_gold = 0
	GameState.set_gold(player_gold, enemy_gold)

func _on_enemy_gold_spent(gold_spent):
	enemy_gold -= gold_spent
	if enemy_gold <= 0:
		enemy_gold = 0
	GameState.set_gold(player_gold, enemy_gold)
