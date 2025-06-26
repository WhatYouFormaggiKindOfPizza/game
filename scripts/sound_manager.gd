extends Node

var instance: SoundManager
var player: AudioStreamPlayer

var audio = load("res://scenes/utils/audio.tscn").instantiate()

func _init() -> void:
	if instance:
		push_error("SoundManager instance already exists. Only one instance is allowed.")
		return
	else:
		instance = self
	
		player = AudioStreamPlayer.new()
		player.name = "SFXPlayer"
		add_child(player)
		add_child(audio)


	
func play_only(stream: AudioStream) -> void:
	if stream:
		player.stop()
		player.stream = stream
		player.play()
	else:
		push_error("No audio stream provided to play_only()")


func play(track_name: String) -> void:
	var track = audio.get_track_by_name(track_name)
	if track:
		play_only(track.audio_stream)
