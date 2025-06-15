class_name HowToPlayPopUp extends Node2D

@onready var game_manager: GameManager = %GameManager
@onready var start_screen: StartScreen = %StartScreen


func _on_exit_pressed() -> void:
	game_manager.scene_manager.show_screen(start_screen)
