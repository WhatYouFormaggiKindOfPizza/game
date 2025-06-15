@tool
class_name PixelLabel extends Label

@export_range(1, 10, 1) var font_scale: int = 2:
	set(value):
		font_scale = value
		update_font_size()

func _ready():
	update_font_size()

func update_font_size():
	if Engine.is_editor_hint():
		var font := get_theme_font("font")
		if font and font is Font:
			var target_size := font_scale * 8
			add_theme_font_size_override("font_size", target_size)
			
