class_name WinScreen extends Node2D

@onready var final_race_support: RelBarContainer = $FinalRaceSupport
@onready var final_support: RelBarContainer = $FinalSupport

func _ready() -> void:
	final_race_support.init(GameManager.instance.entity_groups)
	final_support.init(GameManager.instance.entity_groups)

func _on_exit_pressed() -> void:
	GameManager.instance.restart_game()
