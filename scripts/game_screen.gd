class_name GameScreen extends Node2D

@export var game_manager: GameManager
@export var entity_groups_node: Node #tutaj trzeba podać tego noda który trzyma wszystkie entityGroups


@onready var rel_bar_container: RelBarContainer = %RelBarContainer
@onready var posts_container: HBoxContainer = %PostsContainer
@onready var days_until: DaysUntil = %DaysUntil
@onready var phone: Phone = %Phone
