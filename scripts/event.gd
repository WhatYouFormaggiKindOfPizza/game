class_name Event extends Node2D

var id: int

var title: String
var content: String
var posts: Array[Post]

func _init(event_data: Dictionary) -> void:
	id = event_data.get("id")
	title = event_data.get("title", "")
	content = event_data.get("content", "")

func add_post(post: Post) -> void:
	posts.append(post)
