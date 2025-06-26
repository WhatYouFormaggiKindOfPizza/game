class_name SoundHandler extends AudioStreamPlayer

func _ready() -> void:
    play()
    finished.connect(queue_free)