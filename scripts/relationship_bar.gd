class_name RelationshipBar extends Control

var entity_group: EntityGroup

@export var good_color = Color(0.0, 1.0, 0.0, 1.0)
@export var bad_color = Color(1.0, 0.0, 0.0, 1.0)
@export var change_value_label: PixelLabel

@export var icon: Sprite2D
@export var progress_bar: ProgressBar
@export var race_name: PixelLabel

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


func load_data_from_entity_group() -> void:
	icon.texture = entity_group.icon
	progress_bar.value = entity_group.get_player_relationship_value()
	#var style_box :StyleBox = progress_bar.get_theme_stylebox("fill");
	#style_box.bg_color
	#progress_bar.add_theme_stylebox_override("fill",style_box.bg_color)
	progress_bar.get_theme_stylebox("fill").set_bg_color(entity_group.color)
	race_name.text = entity_group.group_name
	
func refresh() -> void:
	load_data_from_entity_group()
	update_week_change(game_manager.week_data)
	pass

func update_week_change(week_data: WeekData) -> void:
	var current_value: int = entity_group.get_player_relationship_value()
	var start_value: int = week_data.get_prev_player_relationship_value(entity_group)

	print("Entity group: " + entity_group.group_name)
	print("Current value: " + str(current_value))
	print("Start value: " + str(start_value))
	print("change: " + str(current_value - start_value))


	var change = current_value - start_value
	set_change_value_label(change)


func set_change_value_label(value: int) -> void:
	change_value_label.text = str(value)
	print("Setting change value label to: " + change_value_label.text)

	if value > 0:
		change_value_label.change_color(good_color)
		change_value_label.text = "+" + change_value_label.text
	else:
		change_value_label.change_color(bad_color)
