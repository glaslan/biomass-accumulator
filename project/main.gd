extends Node

func _ready() -> void:
	var audio = AudioStreamPlayer3D.new()
	audio.stream = preload("res://squish.wav")
	audio.finished.connect(audio.play)
	audio.volume_db = -5
	add_child(audio)
	audio.play()
