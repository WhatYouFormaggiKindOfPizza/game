class_name Candidate extends Node

static var next_id: int = 0

@export var king_name: String
@export var icon: Texture2D
@export var color: Color
@export var is_player: bool


var current_support: int = 0
var current_support_percent: float = 0
var id: int

func _init() -> void:
	id = next_id
	next_id += 1

static func reset_id() -> void:
	next_id = 0
