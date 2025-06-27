class_name ManagerBase extends Node


var instance: ManagerBase


func _init() -> void:
	_create_instance()


func _create_instance() -> void:
	if instance:
		push_error("%s instance already exists. Only one instance is allowed." % self.name)
		return
	else:
		instance = self


