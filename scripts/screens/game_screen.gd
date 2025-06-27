class_name GameScreen extends Node2D

@export var entity_groups_node: Node #tutaj trzeba podać tego noda który trzyma wszystkie entityGroups


@onready var rel_bar_container: RelBarContainer = %RelBarContainer
@onready var candidate_supp_container: RelBarContainer = %CandidateSupportContainer
@onready var posts_container: HBoxContainer = %PostsContainer
@onready var days_until: DaysUntil = %DaysUntil
@onready var phone: Phone = %Phone

func init() -> void:
	rel_bar_container.init(GameManager.instance.entity_groups)
	candidate_supp_container.init(GameManager.instance.entity_groups)
