class_name StartScreen extends Control

func _ready() -> void:
	show()

func _on_button_pressed() -> void:
	GameManager.instance.start_game()

func _on_how_to_play_pressed() -> void:
	GameManager.instance.scene_manager.show_screen(GameManager.instance.scene_manager.how_to_play_pop_up)
