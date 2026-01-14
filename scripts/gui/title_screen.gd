extends Control

@onready var title: Label = $Title
@onready var play_button: Button = $CenterContainer/VBoxContainer/Play
@onready var how_to_play_button: Button = $CenterContainer/VBoxContainer/HowToPlay
@onready var quit_button: Button = $CenterContainer/VBoxContainer/Quit

func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

func _on_play_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/world.tscn")
	self.hide()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
