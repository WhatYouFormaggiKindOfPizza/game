class_name SceneManager extends Node


@onready var game_screen: GameScreen = %GameScreen
@onready var start_screen: StartScreen = %StartScreen

func hide_all_scenes() -> void:
    game_screen.hide()
    start_screen.hide()


func show_screen(screen: Node) -> void:
    if not screen:
        push_error("Screen is null, cannot show.")
        return

    hide_all_scenes()
    if screen:
        screen.show()



    