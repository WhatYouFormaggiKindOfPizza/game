class_name EntityGroup extends Node2D

static var next_id: int = 0

@export var group_name: String
@export var icon: Texture2D
@export var color: Color

var id: int
var relationships: Array[Support]


func _init() -> void:
	id = next_id
	next_id += 1

static func reset_id() -> void:
	next_id = 0

func init(candidates: Array[Candidate]) -> void:
	# TODO: starting support should be based on the candidate's initial support
	for k in candidates:
		var support = Support.new(k, randi_range(-10, 10))
		relationships.append(support)
	pass


func change_relationship_value(value: int, candidate: Candidate) -> void:
	get_relationship_by_candidate(candidate).change_value(value)


func get_relationship_by_candidate(candidate: Candidate) -> Support:
	for support in relationships:
		if support.candidate == candidate:
			return support
	return null


func get_player_relationship_value() -> int:
	var relationship_value : int;
	for support in relationships:
		if(support.candidate.is_player == true):
			relationship_value = support.value
	return relationship_value



