class_name Board extends Control

@export var game_manager: GameManager
@export var rel_bar_container: RelBarContainer
@onready var week_number_label: Label = $WeekNumber

func init(gm: GameManager) -> void:
    game_manager = gm
    rel_bar_container.init(game_manager.entity_groups, gm)
    gm.next_round_signal.connect(change_week_number)


func change_week_number(week_number: int) -> void:
    week_number_label.text = str(week_number)
