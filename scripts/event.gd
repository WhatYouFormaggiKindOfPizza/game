class_name Event extends Node2D

var id: int

var title: String
var content: String
@export var posts: Array[Post]
var is_available: bool

func _init(event_data: Dictionary) -> void:
	id = event_data.get("id")
	title = event_data.get("title", "")
	content = event_data.get("content", "")
	is_available = true

func add_post(post: Post) -> void:
	posts.append(post)
