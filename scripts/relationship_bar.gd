class_name RelationshipBar extends Control

var object #entity_group albo king

@onready var icon = $HBoxContainer/AspectRatioContainer/Icon
@onready var progress_bar = $HBoxContainer/VBoxContainer/ProgressBar
@onready var label = $HBoxContainer/VBoxContainer/Name

func load_data() -> void:
    icon.texture = object.icon
    progress_bar.get_theme_stylebox("fill").set_bg_color(object.color)
    if(object is EntityGroup):
        progress_bar.value = object.get_player_relationship_value()
        label.text = object.group_name
    if(object is King):
        progress_bar.value = object.current_support_percent
        label.text = object.king_name
    
    
