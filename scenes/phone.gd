class_name Phone
extends Node2D

@onready var label: PixelLabel = $Label

var event_id: int = 0  # ustawiany z zewnątrz

func load_and_display_event(id: int):
	if label == null: #antybug
		return
	var file_path = "res://data/events.json"	
	var json_text = FileAccess.get_file_as_string(file_path)
	var parsed = JSON.parse_string(json_text)
	
	for event in parsed:
		if event.get("id", -1) == id:
			var title = event.get("title", "Brak tytułu")
			var content = event.get("content", "")
			label.text = title + "\n\n" + content
			return
