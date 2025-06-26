class_name IdeologyCompass extends Object

# progress <---> tradition
var cultural: int :
    set = _set_value

# teamwork <---> individualism
var economic: int :
    set = _set_value

# freedom <---> authority
var pressure: int :
    set = _set_value

func _init(_cultural: int, _economic: int, _pressure: int) -> void:
    self.cultural = clamp(_cultural, -100, 100)
    self.economic = clamp(_economic, -100, 100)
    self.pressure = clamp(_pressure, -100, 100)


func _set_value(value: int) -> void:
    cultural = clamp(value, -100, 100)
