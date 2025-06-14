extends Node2D

@export var entity_group: EntityGroup

@onready var icon = $Icon
@onready var progress_bar = $ProgressBar

func _init() -> void:
	icon.texture = entity_group.icon
	progress_bar.tint_progress = entity_group.color
	progress_bar.value = entity_group.get_player_relationship_value()
	
