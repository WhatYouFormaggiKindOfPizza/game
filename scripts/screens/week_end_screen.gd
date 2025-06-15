class_name WeekEndScreen extends Control


var game_manager: GameManager
@export var board: Board


func init(_game_manager: GameManager) -> void:
	self.game_manager = _game_manager
	board.init(game_manager)
