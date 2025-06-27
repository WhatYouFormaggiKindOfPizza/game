class_name Board extends Control

@export var rel_bar_container: RelBarContainer
@export var rel_bar_container2: RelBarContainer
@onready var week_number_label: Label = $WeekNumber

func init() -> void:
	rel_bar_container.init(GameManager.instance.entity_groups)
	rel_bar_container2.init(GameManager.instance.entity_groups)
	GameManager.instance.begin_round_signal.connect(change_week_number)


func change_week_number(round_no: int) -> void:
	week_number_label.text = str(round_no)

