extends Node

var stream : AudioStream = preload("res://squish.wav")
var audio : AudioStreamPlayer

func _ready() -> void:
	audio = AudioStreamPlayer.new()
	audio.stream = stream
	audio.finished.connect(audio.play) # Manually loops the audio
	audio.volume_db = -5
	add_child(audio)


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		audio.play()
	else:
		audio.stop()
