extends Node2D

@onready var title_screen: Control = %TitleScreen
@onready var end_screen: Control = %EndScreen
@onready var tower_buttons: TowerButtons = $GUI/TowerButtons

var game_over: bool = false

func _ready() -> void:
	Input.set_custom_mouse_cursor(
		preload("res://assets/ui/Edinnu_UI_asset_pack/Cursors/Cursor (7).png"),
		Input.CURSOR_ARROW,
		Vector2(0, 0) # hotspot
	)
	
	GameState.global_health_depleted.connect(_on_global_health_depleted)
	
	if title_screen.play_button.pressed:
		title_screen.hide()
		
	title_screen.show()
	end_screen.hide()
	
	Engine.time_scale = 1.0

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		tower_buttons.reset_tower_toggles()

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
