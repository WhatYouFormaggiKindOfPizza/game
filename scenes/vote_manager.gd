class_name VoteManager extends Node2D

var entity_groups: Array[EntityGroup]
var kings: Array[King]

func init(groups: Array[EntityGroup]) -> void:
	entity_groups = groups

func compute_support(_t_king: Array[King]):
	kings = _t_king
