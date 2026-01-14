extends Node2D

func _ready() -> void:
	%TitleScreen.hide()
	%EndScreen.hide()

func _on_end_screen() -> void:
	%EndScreen.show()
