class_name WinScreen extends Node2D

@onready var game_manager: GameManager = %GameManager

func _on_exit_pressed() -> void:
	game_manager.restart_game()
