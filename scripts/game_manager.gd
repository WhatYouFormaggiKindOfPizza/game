class_name GameManager extends Node

@export var max_resolutions_per_week: int = 2
@export var max_turns: int = 16 #TODO: use in turn_end()
@export var show_logs: bool = true
@export var posts_json_path: String = "res://data/posts.json"
@export var events_json_path: String = "res://data/events.json"

@export var post_scene: PackedScene = load("res://scenes/post.tscn")


@onready var kings_parent: Node = %Pretenders
@onready var entity_groups_parent: Node = %EntityGroups
@onready var vote_simulator: VoteSimulator = $VoteSimulator
@onready var scene_manager: SceneManager = %SceneManager

var entity_groups: Array[EntityGroup]
var kings: Array[King]
var posts: Array[Post] = []
var events: Array[Event] = []

var current_event: Event
var current_posts: Array[Post]

var week_data: WeekData = WeekData.new()

var relationship_bar_container: RelBarContainer
var posts_container: HBoxContainer
var days_until: DaysUntil
var phone: Phone

var day: int = 0

func init_entity_groups() -> void:
	for e in entity_groups:
		e.init(kings)

		
func _ready() -> void:
	load_kings_and_entities()
	init_entity_groups()
	load_posts_from_json()
	load_events_from_json()
	
	if show_logs: 
		log_ready()
	vote_simulator.init(entity_groups, kings)
	


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
		var post = post_scene.instantiate().with_data(post_data, self)
		print(post)
		posts.append(post)

	
func load_events_from_json() -> void:
	var json_as_text = FileAccess.get_file_as_string(events_json_path)
	var json_as_dict = JSON.parse_string(json_as_text)

	if !json_as_dict:
		push_error("Error parsing JSON: ", events_json_path)
		return


	if show_logs:
		print("Loaded events from JSON: " + str(json_as_dict))

	for event_data in json_as_dict:
		var event = Event.new(event_data)
		events.append(event)

		if show_logs:
			print("Loaded Events: " + str(event))
	
	assign_events_posts()
	
func assign_events_posts() -> void:
	for event in events:
		for post in posts:
			if (event.id == post.event_id):
				event.add_post(post)
	
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
	
	push_error('Warning: no entity group for name: ' + entity_group_name)
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
	scene_manager.init(self)
	scene_manager.show_screen(scene_manager.game_screen)
	posts_container = scene_manager.game_screen.posts_container
	days_until = scene_manager.game_screen.days_until
	relationship_bar_container = scene_manager.game_screen.rel_bar_container
	phone = scene_manager.game_screen.phone
	scene_manager.run_delayed_inits()

	if show_logs:
		print("Game started")
	next_turn()
		

func next_turn() -> void:
	days_until.set_days(day, max_turns)
	day += 1

	if show_logs:
		print("Next turn started. Day: " + str(day))
	
	#get random event
	current_event = events[randi_range(0, events.size() - 1)]
	phone.load_and_display_event(current_event.id)

	#check if event has 3 required posts
	assert(current_event.posts.size() == 3, "Event with id: " + str(current_event.id) + ", needs 3 posts assigned, found: " + str(current_event.posts.size()))

	# Mocked posts for now | update noone is mocking my posts anymore
	current_posts = current_event.posts
	
	for c in posts_container.get_children():
		posts_container.remove_child(c)

	for post in current_posts:
		posts_container.add_child(post)
		post.setup_scene() 

	# TODO: send player messages from lobbyists


func end_turn() -> void:
	if show_logs:
		print("Ending turn...")
		
	#handles opponents actions
	handle_opponents_actions();

	vote_simulator.update_support_history(kings)
	relationship_bar_container.refresh_relationship_bars()
	run_support_simulation()

	if day >= max_turns:
		end_game()

	elif day % 7 == 0:
		end_round()
	else:
		next_turn()

func end_round() -> void:
	var week_number = int(day / 7.0)

	if show_logs:
		print("Round ended. Week: " + str(week_number))


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
	
	#show week summary (relationships changes of all pretenders)
	var actual_week_supp_difrence = []
	for king in kings:
		actual_week_supp_difrence.append(vote_simulator.show_week_supp_difrence(king, week_number))

	if show_logs:
		print("Week support differences: " + str(actual_week_supp_difrence))

	#TODO: on "next" button click, reset posts and start next turn
	week_data.clear()
	run_support_simulation()
	next_turn()


func end_game() -> void:
	if show_logs:
		print("Game ended after " + str(day) + " days.")

	# TODO: Show final scores and rankings


func run_support_simulation() -> void:
	for king in kings:
		var support = vote_simulator.compute_support(king)
		king.current_support_percent = float(support) / vote_simulator.num_voters * 100.0
		king.current_support = support
		if show_logs:
			print("King: " + king.king_name + " has support: " + str(support))

func handle_opponents_actions() -> void:
	for king in kings:
		if !king.is_player:
			var opponent_post = current_event.posts[randi_range(0, current_event.posts.size() - 1)]
			opponent_post.populate_effects(king)
