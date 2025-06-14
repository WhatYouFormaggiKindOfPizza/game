class_name GameManager extends Node

@onready var kings_parent: Node = %Pretenders
@onready var entity_groups_parent: Node = %EntityGroups


var entity_groups: Array[EntityGroup]
var kings: Array[King]


func _init() -> void:
	
	pass



func init_entity_groups() -> void:
	for e in entity_groups:
		e.init(kings)

		
func _ready() -> void:
	print(entity_groups_parent.name)

	for child in entity_groups_parent.get_children():
		if child is EntityGroup:
			entity_groups.append(child)
		else:
			push_error("Unknown child type: " + str(child))
	
	for child in kings_parent.get_children():
		if child is King:
			kings.append(child)
		else:
			push_error("Unknown child type: " + str(child))

	init_entity_groups()


	print("GameManager is ready with " + str(entity_groups.size()) + " entity groups and " + str(kings.size()) + " kings.")
	for e in entity_groups:
		print("EntityGroup: " + e.group_name + " with ID: " + str(e.id))
	for k in kings:
		print("King: " + k.king_name + " with ID: " + str(k.id) + " and is_player: " + str(k.is_player))
	pass
