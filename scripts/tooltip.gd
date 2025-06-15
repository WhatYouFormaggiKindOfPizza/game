class_name Tooltip extends PanelContainer

@export var is_mouse_following: bool = false
@export var relation_change_scene: PackedScene = null

var OFFSET: Vector2 = Vector2(10, 10)
var opacity_tween: Tween = null

var info_container: VBoxContainer



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


func setup_data(effects: Array[Dictionary]) -> void:
	if not is_inside_tree():
		push_error("Tooltip setup called before Tooltip is added to the scene tree.")
		return

	info_container = get_node("ColorRect/InfoContainer")
	if not info_container:
		push_error("InfoContainer not found in Tooltip.")
		return

	for c in info_container.get_children():
		info_container.remove_child(c)

	for effect in effects:
		if effect["type"] != "CHANGE_RELATIONSHIP":
			continue

		var effect_instance = relation_change_scene.instantiate().with_data(effect)
		info_container.add_child(effect_instance)
