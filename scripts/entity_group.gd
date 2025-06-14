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


func init(kings: Array[King]) -> void:
    # potencjalnie różny typ króla (np elf) może mieć różne relacje startowe
    for k in kings:
        var relationship = {
            "king": k,
            "relationship": 0
        }

        relationships.append(relationship)
    pass


func change_relationship_value(value: int, king: King) -> void:
    var r_idx = relationships.find(
        func(r):
            return r["king"].id == king.id
    )

    relationships[r_idx]["relationship"] += value
    pass