class_name Board extends Control

@export var game_manager: GameManager
@export var rel_bar_container: RelBarContainer

func init(gm: GameManager) -> void:
    game_manager = gm
    rel_bar_container.init(game_manager.entity_groups, gm)