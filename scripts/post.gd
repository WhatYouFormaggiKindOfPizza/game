class_name Post extends Node2D

var id: int
static var next_id: int = 0

# base data
var lobbyist: EntityGroup # TODO: typ jeszcze do zmiany probably
var title: String
var content: String


# publication data
var author: String
var date: String
var likes: int = 0
var comments: Array[Dictionary] = []

# effects
var effects: Array[Dictionary] = []


enum EffectType {
    CHANGE_RELATIONSHIP,
    EVENT,
    NONE,
}



func _init() -> void:
    id = next_id
    next_id += 1




