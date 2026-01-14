extends Control

@onready var player_gold_ui: HBoxContainer = $PlayerGoldUI
@onready var enemy_gold_ui: HBoxContainer = $EnemyGoldUI

func _ready() -> void:
	GameState.global_gold_changed.connect(_on_global_gold_changed)

func _on_global_gold_changed(player_gold, enemy_gold) -> void:
	player_gold_ui.label.set_text(str(player_gold))
	enemy_gold_ui.label.set_text(str(enemy_gold))
