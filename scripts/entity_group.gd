class_name EntityGroup extends Node2D

var id: int
var group_name: String
var relationships: Array[Dictionary]



func init(kings: Array[King]) -> void:
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