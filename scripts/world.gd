extends Node2D

@onready var title_screen: Control = %TitleScreen
@onready var end_screen: Control = %EndScreen

func _ready() -> void:
	GameState.global_health_depleted.connect(_on_global_health_depleted)
	
	if title_screen.play_button.pressed:
		title_screen.hide()
		
	title_screen.show()
	end_screen.hide()
	
	Engine.time_scale = 3.0

func _on_end_screen() -> void:
	end_screen.show()

func _on_global_health_depleted() -> void:
	if GameState.player_current_health <= 0:
		end_screen.label.text = "You lose!"
		end_screen.show() 
	if GameState.enemy_total_health <= 0:
		end_screen.label.text = "You win!"
		end_screen.show()
