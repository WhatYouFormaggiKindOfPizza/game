class_name Audio extends Node

var tracks: Array[AudioTrack] = []

func _ready() -> void:
	print("Initializing Audio Store...")
	# Load all audio tracks from the scene tree
	for child in get_children():
		print("Found child: %s" % child.name)
		if child is AudioTrack:
			tracks.append(child)
		else:
			push_error("Child '%s' is not an AudioTrack." % child.name)


func get_track_by_name(_name: String) -> AudioTrack:
	for track in tracks:
		print("Checking track: %s" % track.title)
		if track.title == _name || track.name == _name:
			return track

	push_error("Audio track with name '%s' not found. Add it to the audio store." % _name)
	return null
