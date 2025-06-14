class_name Post extends Node2D

var id: int
static var next_id: int = 0

# base data
var lobbyist: String # TODO: typ jeszcze do zmiany probably
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


func _init(post_data: Dictionary) -> void:
	id = next_id
	next_id += 1

	lobbyist = post_data.get("lobbyist", "")
	title = post_data.get("title", "")
	content = post_data.get("content", "")
	author = post_data.get("author", "")
	date = post_data.get("date", "")
	likes = post_data.get("likes", 0)

	
	# comments = post_data.get("comments", [])
	
	effects = []
	for effect in post_data.get("effects", []):
		var effect_dict: Dictionary = {
			"type": effect.get("type", EffectType.NONE),
			"target": effect.get("target", ""),
			"value": effect.get("value", 0),
			"event_name": effect.get("event_name", "")
		}
		effects.append(effect_dict)
