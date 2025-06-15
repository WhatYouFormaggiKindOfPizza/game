class_name RelBarContainer extends Control

@export var entity_groups_node: Node #tutaj trzeba podać tego noda który trzyma wszystkie entityGroups
@export var title : String

@onready var box_container = $VBoxContainer
@onready var title_node = $VBoxContainer/Title
const relationship_bar = preload("res://scenes/relationship_bar.tscn")
var entity_groups: Array[Node]

func _ready() -> void:
    title_node.text = title
    entity_groups = entity_groups_node.get_children()
    for entity_group in entity_groups:
        if(entity_group is EntityGroup):
            print("Added entity_group " + entity_group.group_name + " to RelBarContainer")
            box_container.add_child(relationship_bar.instantiate())
            var relBar : RelationshipBar = box_container.get_children().back() as RelationshipBar
            relBar.entity_group = entity_group
            relBar.load_data_from_entity_group()
        
func refresh_relationship_bars() -> void:
    for relBar in box_container.get_children():
        if(relBar is RelationshipBar):
            relBar.load_data_from_entity_group()
