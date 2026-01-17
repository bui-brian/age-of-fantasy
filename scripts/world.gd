extends Node2D

@onready var title_screen: Control = %TitleScreen
@onready var end_screen: Control = %EndScreen

var game_over: bool = false

func _ready() -> void:
	GameState.global_health_depleted.connect(_on_global_health_depleted)
	
	if title_screen.play_button.pressed:
		title_screen.hide()
		
	title_screen.show()
	end_screen.hide()
	
	Engine.time_scale = 3.0

func _on_global_health_depleted() -> void:
	if game_over:
		return
	
	if GameState.player_total_health <= 0:
		game_over = true
		end_screen.label.text = "YOU LOSE"
		end_screen.show()
		
	if GameState.enemy_total_health <= 0:
		game_over = true
		end_screen.label.text = "YOU WIN!"
		end_screen.show()
