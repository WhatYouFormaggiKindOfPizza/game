class_name WeekData extends Node

var posts: Array[Post] = []
var event_resolutions: Array = []
var events: Array = []


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
