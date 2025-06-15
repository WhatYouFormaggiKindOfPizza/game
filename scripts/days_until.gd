class_name DaysUntil extends PanelContainer

@onready var days_label: Label = %Days

func set_days(current_day, max_days) -> void:
	if not days_label:
		push_error("Days label not found in DaysUntil.")
		return
	
	var days_left = max_days - current_day
	days_label.text = str(days_left)
	
	if days_left <= 3:
		days_label.add_color_override("font_color", Color(1, 0, 0))  # Red color for three or fewer days
	# else:
	#     days_label.add_color_override("font_color", Color(1, 1, 1))  # Default color for positive days
