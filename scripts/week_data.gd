class_name WeekData extends Node

var posts: Array[Post] = []
var event_resolutions: Array = []
var events: Array = []
var start_week_entity_groups: Array = []


func set_start_week_entity_groups(groups: Array[EntityGroup]) -> void:
	for group in groups:
		if group is EntityGroup:
			var data = {
				"id": group.id,
				"group_name": group.group_name,
				"player_relationship_value": group.get_player_relationship_value(),
			}
			start_week_entity_groups.append(data)
		else:
			push_error("Expected EntityGroup, got: " + str(group))

	# var _clone = groups.duplicate(true)
	# start_week_entity_groups = _clone
	# print(_clone)
	# print(groups)

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


func get_prev_player_relationship_value(entity_group: EntityGroup) -> int:
	print("get_prev_player_relationship_value for entity group: " + entity_group.group_name)
	for group in start_week_entity_groups:
		if group["id"] == entity_group.id:
			return group["player_relationship_value"]

	push_error("Entity group not found in start week entity groups: " + entity_group.group_name)
	return -1
