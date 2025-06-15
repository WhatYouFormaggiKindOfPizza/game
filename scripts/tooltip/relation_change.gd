class_name RelationChange extends HBoxContainer

@export var good_color = Color(0.0, 1.0, 0.0, 1.0)
@export var bad_color = Color(1.0, 0.0, 0.0, 1.0)

var target: String
var value: int
var event_name: String

@onready var target_label: Label
@onready var value_label: Label


func with_data(effect_data: Dictionary) -> RelationChange:
	if not effect_data:
		push_error("Effect data is empty, cannot initialize RelationChange.")
		return self


	target = effect_data.get("target", "")
	value = effect_data.get("value", 0)

	target_label = get_node("TargetLabel")
	value_label = get_node("ValueLabel")

	if not target_label or not value_label:
		push_error("TargetLabel or ValueLabel not found in RelationChange.")
		return self

	target_label.text = target
	# value_label.text = str(value)

	if value > 0:
		value_label.change_color(good_color)
		value_label.text = "+"
		if value > 10:
			value_label.text += "+"
	else:
		value_label.text = "-"
		value_label.change_color(bad_color)
		if value < -10:
			value_label.text += "-"


	return self
