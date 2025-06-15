class_name RelBarContainer extends Control

@export var game_screen: Node
var objects_group_node: Node #tutaj trzeba podać tego noda który trzyma wszystkie objekty (entity_group albo king)
@export var title : String
@export var is_entity_group_container : bool = true;

@onready var box_container = $VBoxContainer
@onready var title_node = $VBoxContainer/Title
const relationship_bar = preload("res://scenes/relationship_bar.tscn")
var objects: Array[Node] #objekty ktore zaladujemy do naszych relationship_bars (entity_group albo king)

func _ready() -> void:
    if is_entity_group_container:
        objects_group_node = game_screen.entity_groups_node
    else:
        objects_group_node = game_screen.kings_node
    title_node.text = title
    
    objects = objects_group_node.get_children()
    for object in objects:
        if(object is EntityGroup || object is King):
            box_container.add_child(relationship_bar.instantiate())
            var relBar : RelationshipBar = box_container.get_children().back() as RelationshipBar
            relBar.object = object
            relBar.load_data()
        if(object is EntityGroup):
            print("Added entity_group " + object.group_name + " to RelBarContainer")
        if(object is King):
            print("Added king " + object.king_name + " to RelBarContainer")
            
        
func refresh_relationship_bars() -> void:
    for relBar in box_container.get_children():
        if(relBar is RelationshipBar):
            relBar.load_data()
