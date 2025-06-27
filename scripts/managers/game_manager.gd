extends ManagerBase


var entities_store: EntitiesStore = load("res://scenes/stores/entities.tscn").instantiate()
var vote_simulator: VoteSimulator = preload("res://scripts/vote_simulator.gd").new()


@export var max_resolutions_per_week: int = 2
@export var max_turns: int = 16 #TODO: use in turn_end()
@export var show_logs: bool = true
@export var posts_json_path: String = "res://data/posts.json"
@export var events_json_path: String = "res://data/events.json"

@export var post_scene: PackedScene = load("res://scenes/post.tscn")


var posts: Array[Post] = []
var events: Array[Event] = []

var current_event: Event

var week_data: WeekData = WeekData.new()


var day: int = 0

signal begin_round_signal(week_number: float)
signal end_round_signal(week_number: float)
signal begin_turn_signal()
signal end_turn_signal()



var entity_groups: Array[EntityGroup] :
	get :
		return entities_store.entity_groups

var candidates: Array[Candidate] :
	get :
		return entities_store.candidates



func _init() -> void:
	super._init()
	add_child(entities_store)


func _ready() -> void:
	load_posts_from_json()
	load_events_from_json()
	
	if show_logs: 
		log_ready()

	vote_simulator.init(entity_groups, candidates)
	



func load_posts_from_json() -> void:
	var json_as_text = FileAccess.get_file_as_string(posts_json_path)
	var json_as_dict = JSON.parse_string(json_as_text)

	if !json_as_dict:
		push_error("Error parsing JSON: ", posts_json_path)
		return

	for post_data in json_as_dict:
		var post = post_scene.instantiate().with_data(post_data)
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
	

func get_player() -> Candidate:
	return entities_store.get_player()

	
func get_entity_group(entity_group_name: String) -> EntityGroup:
	for entity_group in entities_store.entity_groups:
		if (entity_group.group_name == entity_group_name):
			return entity_group
	
	push_error('Warning: no entity group for name: ' + entity_group_name)
	return null

# logs
func log_ready() -> void:
	print("GameManager is ready")
	
	print("--- Entity Groups ---")
	print("Loaded " + str(entities_store.entity_groups.size()) + " entity groups from scene.")
	for e in entities_store.entity_groups:
		print("EntityGroup: " + e.group_name + " with ID: " + str(e.id))

	print("--- Candidates ---")
	print("Loaded " + str(entities_store.candidates.size()) + " candidates from scene.")
	for k in entities_store.candidates:
		print("Candidate: " + k.king_name + " with ID: " + str(k.id) + " and is_player: " + str(k.is_player))
		
	print("--- Posts ---")
	print("Loaded " + str(posts.size()) + " posts from JSON.")
	for p in posts:
		print("Post: " + p.title + " with ID: " + str(p.id))


func start_game() -> void:
	SceneManager.instance.load_scene(SceneManager.game_screen)
	week_data.set_start_week_entity_groups(entities_store.entity_groups)

	if show_logs:
		print("Game started")
	
	next_round()
		

func next_turn() -> void:
	#get random event	
	current_event = events[randi_range(0, events.size() - 1)]
	while !current_event.is_available:
		current_event = events[randi_range(0, events.size() - 1)]

	current_event.is_available = false

	# increment day
	day += 1
	if show_logs:
		print("Next turn started. Day: " + str(day))

	# emit signal
	begin_turn_signal.emit()
	
	# TODO: send player messages from lobbyists


func end_turn() -> void:
	if show_logs:
		print("Ending turn...")
	
	end_turn_signal.emit()
		
	#handles opponents actions
	handle_opponents_actions();

	vote_simulator.update_support_history(entities_store.candidates)
	run_support_simulation()

	if day >= max_turns:
		end_game()

	elif day % 7 == 0:
		end_round()
	else:
		next_turn()

func next_round() -> void:
	SceneManager.instance.load_scene(SceneManager.game_screen)
	begin_round_signal.emit((day / 7.0) + 1)

	run_support_simulation()
	week_data.clear()
	week_data.set_start_week_entity_groups(entities_store.entity_groups)
	next_turn()

func end_round() -> void:
	SceneManager.instance.load_scene(SceneManager.week_end_screen)
	
	var week_number = int(day / 7.0)
	if show_logs:
		print("Round ended. Week: " + str(week_number))


	# # Get some random event resolutions
	# var number_of_resolutions = RandomNumberGenerator.new().randi_range(1, max_resolutions_per_week)
	# var event_resolutions = []
	# for i in range(number_of_resolutions):
	# 	var idx = RandomNumberGenerator.new().randi() % week_data.event_resolutions.size()
	# 	var er = week_data.event_resolutions.pop_at(idx)
	# 	event_resolutions.append(er)

	# # TODO: Apply effects of the event resolution
	# for er in event_resolutions:
	# 	if show_logs:
	# 		print("Event Resolution: " + str(er))
	# 	#HERE

	end_round_signal.emit((day / 7.0) + 1)


	
	#show week summary (relationships changes of all pretenders)
	var actual_week_supp_difrence = []
	for king in entities_store.candidates:
		actual_week_supp_difrence.append(vote_simulator.show_week_supp_difrence(king, week_number))

	if show_logs:
		print("Week support differences: " + str(actual_week_supp_difrence))


func end_game() -> void:
	if show_logs:
		print("Game ended after " + str(day) + " days.")
		
	var has_player_won = false

	var final_score = []
	for king in entities_store.candidates:
		final_score.append(vote_simulator.compute_support(king))
	var max_score = final_score.max()
	var max_index = final_score.find(max_score)

	if entities_store.candidates[max_index].is_player:
		has_player_won = true # Defaulty false

	if has_player_won == true:
		SceneManager.instance.load_scene(SceneManager.win_screen)
	else:
		SceneManager.instance.load_scene(SceneManager.lose_screen)


func run_support_simulation() -> void:
	for king in entities_store.candidates:
		var support = vote_simulator.compute_support(king)
		king.current_support_percent = float(support) / vote_simulator.num_voters * 100.0
		king.current_support = support
		if show_logs:
			print("Candidate: " + king.king_name + " has support: " + str(support))

func handle_opponents_actions() -> void:
	for king in entities_store.candidates:
		if !king.is_player:
			var opponent_post = current_event.posts[randi_range(0, current_event.posts.size() - 1)]
			opponent_post.populate_effects(king)

# TODO
func restart_game() -> void:
	Candidate.reset_id()
	EntityGroup.reset_id()
	get_tree().reload_current_scene()
