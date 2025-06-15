class_name Post extends Control

var id: int
static var next_id: int = 0

@onready var game_manager: GameManager
@onready var title_label: PixelLabel
@onready var content_label: PixelLabel
@onready var tooltip: Tooltip

var event_id: int

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


func with_data(post_data: Dictionary = {}, gm: GameManager = null) -> Post:
	id = next_id
	next_id += 1
	game_manager = gm	
	event_id = post_data.get("event_id")
	
	if post_data.is_empty():
		push_error("Post data is empty, cannot initialize Post.")
		return

	map_post_data(post_data)
	return self



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


func setup_scene() -> void:
	if not is_inside_tree():
		push_error("Post UI update called before Post is added to the scene tree.")
		return
	
	title_label = get_node("Button/VBoxContainer/PostTitle")
	content_label = get_node("Button/VBoxContainer/PostContent")
	tooltip = get_node("PostTooltip")
	assign_labels()
	tooltip.setup_data(effects)


func assign_labels() -> void:
	if title_label:
		title_label.text = title
	if content_label:
		content_label.text = content


func _on_button_mouse_entered() -> void:
	position.y -= 10  
	tooltip.toggle(true)


func _on_button_mouse_exited() -> void:
	position.y += 10 
	tooltip.toggle(false)

		
func populate_effects(king: King) -> void:
	for effect in effects:
		if effect.get("type") != EffectType.CHANGE_RELATIONSHIP:
			continue
			
		var target_name = effect.get('target')
		var target = game_manager.get_entity_group(target_name)
		if (target != null):
			target.change_relationship_value(effect.get("value"), king)
				


func _on_button_pressed() -> void:
	var player = game_manager.get_player()
	populate_effects(player)
	game_manager.run_support_simulation()
	game_manager.end_turn()
