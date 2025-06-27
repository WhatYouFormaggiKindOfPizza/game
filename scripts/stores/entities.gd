class_name EntitiesStore extends Node

@onready var kings_parent: Node = %Pretenders
@onready var entity_groups_parent: Node = %EntityGroups

var entity_groups: Array[EntityGroup] = [] 
var kings: Array[King] = []


func get_player() -> King:
	var player = null
	
	for king in kings:
		if (king.is_player):
			player = king
			
	if not player:
		push_error("No player found!") 
		return null

	return player



# --- Setup ---


func _ready() -> void:
	load_kings()
	load_entities()
	init_entity_groups()


func load_kings() -> void:
	if kings_parent:
		for child in kings_parent.get_children():
			if child is King:
				kings.append(child)
			else:
				push_error("Unknown child type in kings_parent: " + str(child))


func load_entities() -> void:
	if entity_groups_parent:
		for child in entity_groups_parent.get_children():
			if child is EntityGroup:
				entity_groups.append(child)
			else:
				push_error("Unknown child type in entity_groups_parent: " + str(child))


func init_entity_groups() -> void:
	for e in entity_groups:
		e.init(kings)

		