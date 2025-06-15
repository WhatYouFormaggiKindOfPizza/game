class_name Tooltip extends PanelContainer

var is_visible: bool = true

func _input(event: InputEvent) -> void:
    if is_visible and event is InputEventMouseButton:
        global_position = get_global_mouse_position()