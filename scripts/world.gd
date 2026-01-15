extends Node2D

@onready var title_screen: Control = %TitleScreen
@onready var end_screen: Control = %EndScreen

func _ready() -> void:
	if title_screen.play_button.pressed:
		title_screen.hide()
	title_screen.show()
	end_screen.hide()
	
	Engine.time_scale = 1.0

func _on_end_screen() -> void:
	end_screen.show()
