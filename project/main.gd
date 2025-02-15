extends Node

var stream : AudioStream = preload("res://squish.wav")

func _ready() -> void:
	var audio = AudioStreamPlayer.new()
	audio.stream = stream
	audio.finished.connect(audio.play) # Manually loops the audio
	audio.volume_db = -5
	add_child(audio)
	if audio.playing == false:
		audio.play()
