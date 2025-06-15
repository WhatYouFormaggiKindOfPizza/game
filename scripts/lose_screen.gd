class_name LoseScreen extends Node2D

@onready var game_manager: GameManager = %GameManager
@onready var final_race_support: RelBarContainer = $FinalRaceSupport
@onready var final_support: RelBarContainer = $FinalSupport

func _ready() -> void:
	final_race_support.init(game_manager.entity_groups, game_manager)
	final_support.init(game_manager.entity_groups, game_manager)

func _on_exit_pressed() -> void:
	game_manager.restart_game()
