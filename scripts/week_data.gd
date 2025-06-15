class_name WeekData extends Node

var posts: Array[Post] = []
var event_resolutions: Array = []
var events: Array = []
var start_week_entity_groups: Array[EntityGroup] = []


func set_start_week_entity_groups(groups: Array[EntityGroup]) -> void:
	var _clone = groups.duplicate(true)
	start_week_entity_groups = _clone

func add_post(post: Post) -> void:
	posts.append(post)

	var ers = post.effects.filter(func(e): return e["type"] == Post.EffectType.EVENT)
	event_resolutions.append_array(ers)


func add_event_resolution(event_resolution: Dictionary) -> void:
	event_resolutions.append(event_resolution)


func add_event(event: Dictionary) -> void:
	events.append(event)


func clear() -> void:
	posts.clear()
	event_resolutions.clear()
	events.clear()
