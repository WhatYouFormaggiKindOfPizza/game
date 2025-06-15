class_name RelBarContainer extends Control

@export var screen: Node
@export var title : String

@onready var box_container = $VBoxContainer
@onready var title_node = $VBoxContainer/Title
const relationship_bar = preload("res://scenes/relationship_bar.tscn")
var entity_groups: Array[EntityGroup]

func init(_entity_groups: Array[EntityGroup]) -> void:
	self.entity_groups = _entity_groups

	clear_container()
	title_node.text = title
	for entity_group in _entity_groups:
		# print("Added entity_group " + entity_group.group_name + " to RelBarContainer")
		box_container.add_child(relationship_bar.instantiate())
		var relBar : RelationshipBar = box_container.get_children().back() as RelationshipBar
		relBar.entity_group = entity_group
		relBar.load_data_from_entity_group()
		
func refresh_relationship_bars() -> void:
	for relBar in box_container.get_children():
		if(relBar is RelationshipBar):
			relBar.load_data_from_entity_group()

func clear_container() -> void:
	for child in box_container.get_children():
		if child is RelationshipBar:
			child.queue_free()
