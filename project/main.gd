extends Node

@export var stream : AudioStream

func _ready() -> void:
	var audio = AudioStreamPlayer3D.new()
	audio.stream = stream
	audio.finished.connect(audio.play)
	audio.volume_db = -5
	add_child(audio)
	audio.play()
