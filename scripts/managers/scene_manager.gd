extends ManagerBase


@onready var game_screen: GameScreen = load("res://scenes/screens/game_screen.tscn").instantiate()
@onready var start_screen: StartScreen = load("res://scenes/screens/start_screen.tscn").instantiate()
@onready var week_end_screen: WeekEndScreen = load("res://scenes/screens/week_end_screen.tscn").instantiate()
@onready var how_to_play_pop_up: HowToPlayPopUp = load("res://scenes/screens/how_to_play_pop_up.tscn").instantiate()
@onready var win_screen: WinScreen = load("res://scenes/screens/win_screen.tscn").instantiate()
@onready var lose_screen: LoseScreen = load("res://scenes/screens/lose_screen.tscn").instantiate()

func run_delayed_inits() -> void:
	if game_screen:
		game_screen.init()
	if week_end_screen:
		week_end_screen.init()

func hide_all_scenes() -> void:
	game_screen.hide()
	start_screen.hide()
	week_end_screen.hide()
	how_to_play_pop_up.hide()


func show_screen(screen: Node) -> void:
	if not screen:
		push_error("Screen is null, cannot show.")
		return

	hide_all_scenes()
	if screen:
		screen.show()
