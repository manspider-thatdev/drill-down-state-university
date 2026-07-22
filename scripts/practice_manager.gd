extends Node3D


@onready var command_label: Label = $Control/Label
@onready var command_manager: CommandManager = $CommandManager
@onready var command_audio_manager: CommandAudioManager = $CommandAudioManager

@onready var control_pattern: ControlPattern = $ControlPattern


func _ready() -> void:
	Metronome.turn_off()
	command_audio_manager.set_pitch_scale(Metronome.bpm / 120.0)
	await get_tree().create_timer(2.0).timeout
	Metronome.turn_on()
	
	#var command_queue = control_pattern.create_queue()
	#print(command_queue)


func _on_command_selected(command: int) -> void:
	var command_string: String = Commands.TO_STRING[command]
	
	if command == Commands.NOTHING:
		return
	
	var line_path: StringName = "res://assets/audio/voices/parker/"+command_string+".mp3"
	command_audio_manager.play(line_path)
	
	await Metronome.beat
	command_label.text = command_string
