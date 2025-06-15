class_name RelBarContainer extends Control

@export var title : String
@export var show_week_changed: bool = false
@export var relationship_bar_scene: PackedScene

@onready var box_container = $VBoxContainer
@onready var title_node = $VBoxContainer/Title
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
		print("Initializing RelationshipBar for entity group: " + entity_group.group_name)
		var relBar : RelationshipBar = relationship_bar_scene.instantiate()
		relBar.init(show_week_changed, game_manager)
		relBar.entity_group = entity_group
		relBar.load_data_from_entity_group()
		relBar.update_week_change(game_manager.week_data)
		box_container.add_child(relBar)


func refresh_relationship_bars() -> void:
	for relBar in box_container.get_children():
		if(relBar is RelationshipBar):
			relBar.load_data_from_entity_group()
			relBar.update_week_change(game_manager.week_data)

func clear_container() -> void:
	for child in box_container.get_children():
		if child is RelationshipBar:
			box_container.remove_child(child)
