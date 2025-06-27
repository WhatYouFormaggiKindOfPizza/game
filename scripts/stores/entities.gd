class_name EntitiesStore extends Node

@onready var candidates_parent: Node = %Candidates
@onready var entity_groups_parent: Node = %EntityGroups

var entity_groups: Array[EntityGroup] = [] 
var candidates: Array[Candidate] = []


func get_player() -> Candidate:
	var player = null

	for candidate in candidates:
		if (candidate.is_player):
			player = candidate

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
	if candidates_parent:
		for child in candidates_parent.get_children():
			if child is Candidate:
				candidates.append(child)
			else:
				push_error("Unknown child type in candidates_parent: " + str(child))


func load_entities() -> void:
	if entity_groups_parent:
		for child in entity_groups_parent.get_children():
			if child is EntityGroup:
				entity_groups.append(child)
			else:
				push_error("Unknown child type in entity_groups_parent: " + str(child))


func init_entity_groups() -> void:
	for e in entity_groups:
		e.init(candidates)

		