class_name GameScreen extends Node2D

@onready var posts_container: Control = %PostsContainer
@onready var days_until: DaysUntil = %DaysUntil
@onready var phone: Phone = %Phone

var current_posts: Array[Post]


func _ready() -> void:
	_update_days_until()
	GameManager.instance.begin_turn_signal.connect(_on_turn_begin)


func _on_turn_begin() -> void:
	_update_days_until()
	phone.load_and_display_event(GameManager.instance.current_event.id)
	_handle_turn_event()


func _update_days_until() -> void:
	days_until.set_days(GameManager.instance.day, GameManager.instance.max_turns)


func _handle_turn_event() -> void:
	var current_event = GameManager.instance.current_event

	if current_event.posts.size() > 3:
		# get random 3 posts from the event
		current_event.posts.shuffle()
		current_event.posts = current_event.posts.slice(0, 3)

	# check if event has 3 required posts
	assert(current_event.posts.size() == 3, "Event with id: " + str(current_event.id) + ", needs 3 posts assigned, found: " + str(current_event.posts.size()))

	current_posts = current_event.posts
	
	for c in posts_container.get_children():
		posts_container.remove_child(c)

	for post in current_posts:
		posts_container.add_child(post)
		post.setup_scene() 
