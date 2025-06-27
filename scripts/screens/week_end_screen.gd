class_name WeekEndScreen extends Control


@export var board: Board


func init() -> void:
	board.init()


func next_round() -> void:
	GameManager.instance.next_round()
 


func _on_button_pressed() -> void:
	next_round()
