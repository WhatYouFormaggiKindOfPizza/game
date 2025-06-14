class_name GameManager extends Node


var entity_groups: Array[EntityGroup]
var kings = Array[King]



func _init() -> void:
    # Get all groups from child nodes
    # - kings
    # - entity groups
    
    pass


func init_entity_groups() -> void:
    for e in entity_groups:
        e.init(kings)

