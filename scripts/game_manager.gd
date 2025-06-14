class_name GameManager extends Node

@export var max_resolutions_per_week: int = 2
@export var max_turns: int = 16 #TODO: use in turn_end()
@export var show_logs: bool = true
@export var posts_json_path: String = "res://data/posts.json"

@onready var kings_parent: Node = %Pretenders
@onready var entity_groups_parent: Node = %EntityGroups
@onready var vote_simulator: VoteSimulator = $VoteSimulator
@onready var posts_container: HBoxContainer = %PostsContainer

var entity_groups: Array[EntityGroup]
var kings: Array[King]
var posts: Array[Post] = []

var week_data: WeekData = WeekData.new()

var day: int = 0

func init_entity_groups() -> void:
	for e in entity_groups:
		e.init(kings)

		
func _ready() -> void:
	load_kings_and_entities()
	init_entity_groups()
	load_posts_from_json()
	if show_logs: 
		log_ready()
	vote_simulator.init(entity_groups)
	start_game()


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

	for post_data in json_as_dict:
		var post = Post.new(post_data, self)
		posts.append(post)

	
func get_player() -> King:
	var player = null
	
	for king in kings:
		if (king.is_player):
			player = king
			
	assert(player, "Brak gracza!")
	
	return player
	
func get_entity_group(entity_group_name: String) -> EntityGroup:
	for entity_group in entity_groups:
		if (entity_group.group_name == entity_group_name):
			return entity_group
	
	print('Warning: no entity group for name: ' + entity_group_name)
	return null
	
# logs
func log_ready() -> void:
	print("GameManager is ready")
	
	print("--- Entity Groups ---")
	print("Loaded " + str(entity_groups.size()) + " entity groups from scene.")
	for e in entity_groups:
		print("EntityGroup: " + e.group_name + " with ID: " + str(e.id))

	print("--- Kings ---")
	print("Loaded " + str(kings.size()) + " kings from scene.")
	for k in kings:
		print("King: " + k.king_name + " with ID: " + str(k.id) + " and is_player: " + str(k.is_player))
		
	print("--- Posts ---")
	print("Loaded " + str(posts.size()) + " posts from JSON.")
	for p in posts:
		print("Post: " + p.title + " with ID: " + str(p.id))


func start_game() -> void:
	if show_logs:
		print("Game started")
	next_turn()
		

func next_turn() -> void:
	day += 1

	if show_logs:
		print("Next turn started. Day: " + str(day))
	
	#TODO: get random event

	#TODO: from event get posts

	# Mocked posts for now 
	var current_posts: Array[Post] = posts.slice(0, 3)

	for c in posts_container.get_children():
		c.queue_free()  # Clear previous posts

	for post in current_posts:
		posts_container.add_child(post)

	# TODO: send player messages from lobbyists


func end_turn() -> void:
	print("Ending turn...")  # Placeholder for ending the turn logic
	pass


func end_round() -> void:
	if show_logs:
		print("Round ended. Week: " + str(day / 7))


	# Get some random event resolutions
	var number_of_resolutions = RandomNumberGenerator.new().randi_range(1, max_resolutions_per_week)
	var event_resolutions = []
	for i in range(number_of_resolutions):
		var idx = RandomNumberGenerator.new().randi() % week_data.event_resolutions.size()
		var er = week_data.event_resolutions.pop_at(idx)
		event_resolutions.append(er)
		

	# TODO: Apply effects of the event resolution
	for er in event_resolutions:
		if show_logs:
			print("Event Resolution: " + str(er))
		#HERE


	# TODO: show event resolutions
	# TODO: show week summary (relationships changes of all pretenders)
	
	week_data.clear()  # Clear week data for the next round
