extends Node3D


@onready var command_label: Label = $Control/Label
@onready var command_manager: CommandManager = $CommandManager
@onready var command_audio_manager: CommandAudioManager = $CommandAudioManager

@onready var control_pattern: ControlPattern = $ControlPattern


var audio_path_prefix: StringName = "res://assets/audio/voices/parker/"
var audio_tempo: String = "120/"


func _ready() -> void:
	Metronome.turn_off()
	
	var tempo_dirs := Array(DirAccess.get_directories_at(audio_path_prefix))
	var recorded_tempos := tempo_dirs.map(func(dir): return int(dir))
	recorded_tempos.sort_custom(
		func(a: int, b: int): return abs(a - Metronome.bpm) < abs(b - Metronome.bpm)
	)
	audio_tempo = str(recorded_tempos[0]) + "/"
	
	command_audio_manager.set_pitch_scale(float(Metronome.bpm) / float(recorded_tempos[0]))
	
	await get_tree().create_timer(1.0).timeout
	Metronome.turn_on()


func _on_command_selected(command: int) -> void:
	var command_string: String = Commands.TO_STRING[command]
	
	if command == Commands.NOTHING:
		return
	
	var line_path: StringName = audio_path_prefix + audio_tempo + command_string + ".mp3"
	command_audio_manager.play(line_path)
	
	await Metronome.beat
	command_label.text = command_string
