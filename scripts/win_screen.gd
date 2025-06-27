class_name WinScreen extends Node2D


func _on_exit_pressed() -> void:
	GameManager.instance.restart_game()
