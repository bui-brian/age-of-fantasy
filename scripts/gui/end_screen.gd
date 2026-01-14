extends Control

@onready var label: Label = $Label
@onready var play_button: Button = $CenterContainer/VBoxContainer/PlayAgainButton
@onready var main_menu_button: Button = $CenterContainer/VBoxContainer/MainMenuButton
@onready var quit_button: Button = $CenterContainer/VBoxContainer/QuitButton

@export var title_screen: Control

func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)

func _on_main_menu_button_pressed() -> void:
	title_screen.show()
	self.hide()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
