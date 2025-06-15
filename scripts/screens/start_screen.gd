class_name StartScreen extends Control

@onready var game_manager: GameManager = %GameManager

func _ready() -> void:
	show()

func _on_button_pressed() -> void:
	game_manager.start_game()

func _on_how_to_play_pressed() -> void:
	game_manager.scene_manager.show_screen(game_manager.scene_manager.how_to_play_pop_up)
