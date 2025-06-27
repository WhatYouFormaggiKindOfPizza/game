class_name HowToPlayPopUp extends Node2D

@onready var start_screen: StartScreen = %StartScreen


func _on_exit_pressed() -> void:
	GameManager.instance.scene_manager.show_screen(start_screen)
