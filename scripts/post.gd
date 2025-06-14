class_name Post extends Node2D

@onready var title_label: Label = $Title
@onready var content_label: Label = $Content


var id: int
static var next_id: int = 0

@onready var game_manager: GameManager

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



func _init(post_data: Dictionary = {}, gm: GameManager = null) -> void:
	id = next_id
	next_id += 1
	game_manager = gm

	if post_data.is_empty():
		push_error("Post data is empty, cannot initialize Post.")
		return

	map_post_data(post_data)
	assign_labels()



func map_post_data(post_data: Dictionary) -> void:
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
			"event_name": effect.get("event_name", "") # TODO: change to event_resolution_name (or just move to event json)
		}
		effects.append(effect_dict)


func assign_labels() -> void:
	if title_label:
		title_label.text = title
	if content_label:
		content_label.text = content


func _on_button_mouse_entered() -> void:
	position.y -= 10  


func _on_button_mouse_exited() -> void:
	position.y += 10 

		
func populate_effects(king: King) -> void:
	for effect in effects:
		var target_name = effect.get('target')
		var target = game_manager.get_entity_group(target_name)
		if (target != null):
			target.change_relationship_value(effect.get("value"), king)
				


func _on_button_pressed() -> void:
	var player = game_manager.get_player()
	populate_effects(player)
	game_manager.end_turn()
