class_name EndScreen extends Control

@onready var game_manager: GameManager = %GameManager
@onready var color_rect: ColorRect = $ColorRect

func _on_button_pressed() -> void:
	game_manager.start_game() # Restartuje grę

func show_scores(has_player_won: bool) -> void:
	if has_player_won:
		color_rect.color = Color(0,1,0,1)
	else:
		color_rect.color = Color(1,0,0,1)
		
