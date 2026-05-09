class_name CommandAudioManager
extends Node


@onready var audio_stream_players: Array[AudioStreamPlayer2D] = [
	$AudioStreamPlayer1,
	$AudioStreamPlayer2,
]

var index: int = 0


func play(audio_stream: StringName) -> void:
	audio_stream_players[index].stream = load(audio_stream)
	audio_stream_players[index].play()
	index = (index + 1) % 2


func set_pitch_scale(value: float) -> void:
	audio_stream_players[0].pitch_scale = value
	audio_stream_players[1].pitch_scale = value
