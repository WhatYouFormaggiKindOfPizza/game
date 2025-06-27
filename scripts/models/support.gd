class_name Support extends Object

var MIN = 0
var MAX = 100

var candidate: Candidate
var value: int = 0 :
    get = get_value,
    set = set_value


var _prev_value: int = 0

func _init(_candidate: Candidate, start_support: int = 0) -> void:
    candidate = _candidate
    value = start_support


func get_value() -> int:
    return value


func set_value(val: int) -> void:
    _prev_value = value
    value = val

    value = clamp(value, MIN, MAX)


func change_value(change: int) -> void:
    set_value(value + change)