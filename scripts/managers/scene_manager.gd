extends ManagerBase

var game_screen: String = "res://scenes/screens/game_screen.tscn"
var start_screen: String = "res://scenes/screens/start_screen.tscn"
var week_end_screen: String = "res://scenes/screens/week_end_screen.tscn"
var how_to_play_pop_up: String = "res://scenes/screens/how_to_play_pop_up.tscn"
var win_screen: String = "res://scenes/screens/win_screen.tscn"
var lose_screen: String = "res://scenes/screens/lose_screen.tscn"


func _init() -> void:
	super._init()


func load_scene(scene_path: String) -> void:
	if not ResourceLoader.exists(scene_path):
		push_error("Scene not found: " + scene_path)

	var status = get_tree().change_scene_to_file(scene_path)
	assert( status == OK, "Failed to load scene: " + scene_path)

	
	
