@tool
class_name PixelLabel extends Label

@export_range(1, 10, 1) var font_scale: int = 2:
	set(value):
		font_scale = value
		inspector_update_font_size()

@export var color: Color = Color(0, 0, 0, 1):
	set(value):
		color = value
		inspector_update_font_color()


func _ready():
	inspector_update_font_size()

func inspector_update_font_size():
	if Engine.is_editor_hint():
		var font := get_theme_font("font")
		if font and font is Font:
			var target_size := font_scale * 8
			add_theme_font_size_override("font_size", target_size)
			
func inspector_update_font_color():
	if Engine.is_editor_hint():
		var font := get_theme_font("font")
		if font and font is Font:
			add_theme_color_override("font_color", color)

func change_color(new_color: Color) -> void:
	add_theme_color_override("font_color", new_color)