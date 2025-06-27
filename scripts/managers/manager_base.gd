class_name ManagerBase extends Node

var instance: ManagerBase

func _init() -> void:
	if instance:
		push_error("%s instance already exists. Only one instance is allowed." % self.name)
		return
	else:
		instance = self
	
