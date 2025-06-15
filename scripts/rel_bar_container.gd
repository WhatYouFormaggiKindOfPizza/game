class_name RelBarContainer extends Control

@export var title : String
@export var show_week_changed: bool = false
@export var relationship_bar_scene: PackedScene
@export var is_entity_group_container : bool = true;

@onready var box_container = $VBoxContainer
@onready var title_node = $VBoxContainer/Title
var objects

var game_manager: GameManager

func init(_objects: Array[EntityGroup], _gm: GameManager) -> void:
	game_manager = _gm
	title_node.text = title
	
	if(is_entity_group_container):
		self.objects = game_manager.entity_groups
	else:
		self.objects = game_manager.kings
	
	clear_container()
	init_entities()
	

func init_entities() -> void:
	for object in objects:
		var relBar : RelationshipBar = relationship_bar_scene.instantiate()
		relBar.init(show_week_changed, game_manager)
		relBar.object = object
		relBar.load_data_from_object()
		relBar.update_week_change(game_manager.week_data)
		box_container.add_child(relBar)


func refresh_relationship_bars() -> void:
	for relBar in box_container.get_children():
		if(relBar is RelationshipBar):
			relBar.load_data_from_object()
			relBar.update_week_change(game_manager.week_data)

func clear_container() -> void:
	for child in box_container.get_children():
		if child is RelationshipBar:
			box_container.remove_child(child)
