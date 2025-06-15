class_name StartScreen extends Control

@onready var game_manager: GameManager = %GameManager

func _ready() -> void:
	show()

func _on_button_pressed() -> void:
	game_manager.start_game()
