class_name GameManager extends Node

@export var show_logs: bool = true
@export var posts_json_path: String = "res://data/posts.json"

@onready var kings_parent: Node = %Pretenders
@onready var entity_groups_parent: Node = %EntityGroups


var entity_groups: Array[EntityGroup]
var kings: Array[King]
var posts: Array[Post] = []


func _init() -> void:
	
	pass



func init_entity_groups() -> void:
	for e in entity_groups:
		e.init(kings)

		
func _ready() -> void:
	load_kings_and_entities()
	init_entity_groups()
	load_posts_from_json()
	if show_logs: 
		log_ready()


func load_kings_and_entities() -> void:
	for child in entity_groups_parent.get_children():
		if child is EntityGroup:
			entity_groups.append(child)
		else:
			push_error("Unknown child type: " + str(child))
	
	for child in kings_parent.get_children():
		if child is King:
			kings.append(child)
		else:
			push_error("Unknown child type: " + str(child))


func load_posts_from_json() -> void:
	var json_as_text = FileAccess.get_file_as_string(posts_json_path)
	var json_as_dict = JSON.parse_string(json_as_text)

	if !json_as_dict:
		push_error("Error parsing JSON: ", posts_json_path)
		return


	if show_logs:
		print("Loaded posts from JSON: " + str(json_as_dict))

	for post_data in json_as_dict:
		var post = Post.new(post_data)
		posts.append(post)

		if show_logs:
			print("Loaded Post: " + str(post))


	pass

# logs

func log_ready() -> void:
	print("GameManager is ready with " + str(entity_groups.size()) + " entity groups and " + str(kings.size()) + " kings.")
	for e in entity_groups:
		print("EntityGroup: " + e.group_name + " with ID: " + str(e.id))
	for k in kings:
		print("King: " + k.king_name + " with ID: " + str(k.id) + " and is_player: " + str(k.is_player))
	pass
