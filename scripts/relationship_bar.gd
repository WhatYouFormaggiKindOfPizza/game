class_name RelationshipBar extends Control

var entity_group: EntityGroup

@onready var icon = $HBoxContainer/AspectRatioContainer/Icon
@onready var progress_bar = $HBoxContainer/VBoxContainer/ProgressBar
@onready var race_name = $HBoxContainer/VBoxContainer/Name

func load_data_from_entity_group() -> void:
	icon.texture = entity_group.icon
	progress_bar.value = entity_group.get_player_relationship_value()
	#var style_box :StyleBox = progress_bar.get_theme_stylebox("fill");
	#style_box.bg_color
	#progress_bar.add_theme_stylebox_override("fill",style_box.bg_color)
	progress_bar.get_theme_stylebox("fill").set_bg_color(entity_group.color)
	race_name.text = entity_group.group_name


func show_week_change(week_data: WeekData) -> void:
	week_data.posts