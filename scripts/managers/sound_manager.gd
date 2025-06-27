extends Node

var instance: SoundManager
var player: AudioStreamPlayer

var audio: Audio = load("res://scenes/utils/audio.tscn").instantiate()
var sound_handler_script: GDScript = load("res://scripts/models/sound_handler.gd")

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
		_play(track)


func _play(track: AudioTrack, variance: float = 0.0) -> void:
	var p: AudioStreamPlayer = AudioStreamPlayer.new()
	p.script       = sound_handler_script
	p.bus          = "Master"
	p.stream       = track.audio_stream
	p.name         = track.title
	p.pitch_scale  = 1.0 + randf_range(-variance, variance)
	add_child(p)
