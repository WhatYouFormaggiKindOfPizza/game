class_name RelBarContainer extends Control

@export var screen: Node
@export var title : String
@export var show_week_change: bool = false

@onready var box_container = $VBoxContainer
@onready var title_node = $VBoxContainer/Title
const relationship_bar = preload("res://scenes/relationship_bar.tscn")
var entity_groups: Array[EntityGroup]

var game_manager: GameManager

func init(_entity_groups: Array[EntityGroup], _gm: GameManager) -> void:
	self.entity_groups = _entity_groups
	game_manager = _gm
	title_node.text = title

	clear_container()
	init_entities()
	

func init_entities() -> void:
	for entity_group in entity_groups:
		# print("Added entity_group " + entity_group.group_name + " to RelBarContainer")
		box_container.add_child(relationship_bar.instantiate())
		var relBar : RelationshipBar = box_container.get_children().back() as RelationshipBar
		relBar.entity_group = entity_group
		relBar.load_data_from_entity_group()


func refresh_relationship_bars() -> void:
	for relBar in box_container.get_children():
		if(relBar is RelationshipBar):
			relBar.load_data_from_entity_group()
			relBar.set_color(relBar.entity_group.color)
			relBar.show_week_change(game_manager.week_data)
			# if show_week_change:

	

func clear_container() -> void:
	for child in box_container.get_children():
		if child is RelationshipBar:
			child.queue_free()
