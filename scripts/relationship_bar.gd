class_name RelationshipBar extends Control

var object #entity_group albo king

@export var good_color = Color(0.0, 1.0, 0.0, 1.0)
@export var bad_color = Color(1.0, 0.0, 0.0, 1.0)
@export var change_value_label: PixelLabel

@export var icon: Sprite2D
@export var progress_bar: ProgressBar
@export var label: PixelLabel

var game_manager: GameManager

func init(show_week_change: bool, gm : GameManager) -> void:
	game_manager = gm
	if show_week_change:
		change_value_label.show()
	else:
		change_value_label.hide()

	assign_data_refresh_to_signals_kurwa_wszystkich()


func assign_data_refresh_to_signals_kurwa_wszystkich() -> void:
	game_manager.next_turn_signal.connect(refresh)
	game_manager.end_turn_signal.connect(refresh)
	pass


func load_data_from_object() -> void:
	icon.texture = object.icon
	progress_bar.get_theme_stylebox("fill").set_bg_color(object.color)
	if(object is EntityGroup):
		progress_bar.value = object.get_player_relationship_value()
		label.text = object.group_name
	if(object is King):
		progress_bar.value = object.current_support_percent
		label.text = object.king_name
	
func refresh() -> void:
	load_data_from_object()
	update_week_change(game_manager.week_data)
	pass

func update_week_change(week_data: WeekData) -> void:
	if(object is EntityGroup):
		var current_value: int = object.get_player_relationship_value()
		var start_value: int = week_data.get_prev_player_relationship_value(object)

		var change = current_value - start_value
		set_change_value_label(change)
	if(object is King):
		pass #TODO


func set_change_value_label(value: int) -> void:
	change_value_label.text = str(value)

	if value > 0:
		change_value_label.change_color(good_color)
		change_value_label.text = "+" + change_value_label.text
	else:
		change_value_label.change_color(bad_color)
