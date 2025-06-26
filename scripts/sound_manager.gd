extends Node

var instance: SoundManager
var player: AudioStreamPlayer

func _init() -> void:
	player = AudioStreamPlayer.new()
	player.name = "SFXPlayer"
	add_child(player)
	instance = self

	
func play_only(stream: AudioStream) -> void:
	if stream:
		player.stop()
		player.stream = stream
		player.play()
	else:
		push_error("No audio stream provided to play_only()")



func play(stream: AudioStream) -> void:
	if stream:
		player.stream = stream
		player.play()
	else:
		push_error("No audio stream provided to play()")
