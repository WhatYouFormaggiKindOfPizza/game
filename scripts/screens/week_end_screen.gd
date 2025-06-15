class_name WeekEndScreen extends Control


@export var game_manager: GameManager
@export var board: Board


func init(_game_manager: GameManager) -> void:
	self.game_manager = _game_manager
	board.init(game_manager)


func next_round() -> void:
	game_manager.next_round()
 


func _on_button_pressed() -> void:
	next_round()
