class_name RelBarContainer extends Control

@export var title : String
@export var show_week_changed: bool = false
@export var relationship_bar_scene: PackedScene
@export var is_entity_group_container : bool = true;

@onready var box_container = $VBoxContainer
@onready var title_node = $VBoxContainer/Title
var objects

func _init() -> void:
	if(is_entity_group_container):
		objects = GameManager.instance.entity_groups
	else:
		objects = GameManager.instance.candidates
	

func _ready() -> void:
	title_node.text = title
	clear_container()
	init_entities()

	

func init_entities() -> void:
	for object in objects:
		var relBar : RelationshipBar = relationship_bar_scene.instantiate()
		relBar.init(show_week_changed)
		relBar.object = object
		relBar.load_data_from_object()
		relBar.update_week_change(GameManager.instance.week_data)
		box_container.add_child(relBar)


func refresh_relationship_bars() -> void:
	for relBar in box_container.get_children():
		if(relBar is RelationshipBar):
			relBar.load_data_from_object()
			relBar.update_week_change(GameManager.instance.week_data)

func clear_container() -> void:
	for child in box_container.get_children():
		if child is RelationshipBar:
			box_container.remove_child(child)
