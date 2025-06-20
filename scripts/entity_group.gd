class_name EntityGroup extends Node2D

static var next_id: int = 0

@export var group_name: String
@export var icon: Texture2D
@export var color: Color

var id: int
var relationships: Array[Dictionary]


func _init() -> void:
	id = next_id
	next_id += 1

static func reset_id() -> void:
	next_id = 0

func init(kings: Array[King]) -> void:
	# potencjalnie różny typ króla (np elf) może mieć różne relacje startowe
	for k in kings:
		var relationship = {
			"king": k,
			"relationship": randi_range(45, 55)
		}

		relationships.append(relationship)
	pass


func change_relationship_value(value: int, king: King) -> void:
	for relationship in relationships:
		if relationship.get('king') == king:
			relationship["relationship"] += value
			
			#check and adjust for relationships value limits
			if (relationship["relationship"] > 100):
				relationship["relationship"] = 100
			elif (relationship["relationship"] < 0):
				relationship["relationship"] = 0

func get_player_relationship_value() -> int:
	var relationship_value : int;
	for relationship in relationships:
		if(relationship["king"].is_player == true):
			relationship_value = relationship['relationship']
	return relationship_value
