extends Control


@onready var label: Label = $Label
@onready var command_audio_manager: CommandAudioManager = $CommandAudioManager

@export_dir var voice_path: String


func _ready() -> void:
	var dir := DirAccess.open(voice_path)
	if !dir:
		label.text = voice_path + " not found!"
		return
	
	dir.list_dir_begin()
	var file_name: String = dir.get_next()
	
	Metronome.bpm = 120
	Metronome.turn_on()
	
	while file_name != "":
		if file_name.ends_with(".import"):
			file_name = dir.get_next()
			continue
		
		await Metronome.beat
		await Metronome.beat
		await Metronome.beat
		await Metronome.beat
		command_audio_manager.play(voice_path + "/" + file_name)
		label.text = voice_path + "/" + file_name
		file_name = dir.get_next()
	
	dir.list_dir_end()
