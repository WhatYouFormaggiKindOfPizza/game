class_name Tooltip extends PanelContainer

@export var is_mouse_following: bool = false

var OFFSET: Vector2 = Vector2(10, 10)
var opacity_tween: Tween = null


func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if is_visible and is_mouse_following and event is InputEventMouseMotion:
		global_position = get_global_mouse_position() + OFFSET


func toggle(on: bool) -> void:
	if on:
		show()
		modulate.a = 0.0
		tween_opacity(1.0)
	else:
		modulate.a = 1.0
		await tween_opacity(0.0).finished
		hide()


func tween_opacity(target_alpha: float, duration: float = 0.0) -> Tween:
	if opacity_tween:
		opacity_tween.kill()
	opacity_tween = get_tree().create_tween()
	opacity_tween.tween_property(self, "modulate:a", target_alpha, duration)
	return opacity_tween
