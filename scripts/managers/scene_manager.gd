extends Node

var game_manager: GameManager

@onready var game_screen: GameScreen = %GameScreen
@onready var start_screen: StartScreen = %StartScreen
@onready var week_end_screen: WeekEndScreen = %WeekEndScreen
@onready var how_to_play_pop_up: HowToPlayPopUp = %HowToPlayPopUp
@onready var win_screen: WinScreen = %WinScreen
@onready var lose_sceen: LoseScreen = %LoseScreen

func init(gm: GameManager) -> void:
	game_manager = gm

func run_delayed_inits() -> void:
	if game_screen:
		game_screen.init(game_manager)
	if week_end_screen:
		week_end_screen.init(game_manager)

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
