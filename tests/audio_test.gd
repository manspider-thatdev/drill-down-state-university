extends Control


@onready var label: Label = $Label
@onready var command_audio_manager: CommandAudioManager = $CommandAudioManager

@export_dir var voice_path: String

var tempo_paths: Array[String] = ["105/", "120/", "135/", "150/", "165/", "180/", "195/"]
var test_tempos: Array[String] = tempo_paths


func test_directories(directory_path: String, tempo: int) -> void:
	var dir := DirAccess.open(directory_path)
	if !dir:
		label.text = directory_path + " not found!"
		return
	
	dir.list_dir_begin()
	var file_name: String = dir.get_next()
	
	Metronome.bpm = tempo
	
	while file_name != "":
		if file_name.ends_with(".import"):
			file_name = dir.get_next()
			continue
		
		await Metronome.beat
		await Metronome.beat
		await Metronome.beat
		await Metronome.beat
		command_audio_manager.play(
			directory_path + file_name
		)
		label.text = directory_path + file_name
		file_name = dir.get_next()
	
	dir.list_dir_end()
	await Metronome.beat
	await Metronome.beat
	await Metronome.beat
	await Metronome.beat


func _on_tempo_option_item_selected(index: int) -> void:
	if index == 0:
		test_tempos = tempo_paths
		return
	test_tempos = [tempo_paths[index - 1]]


func _on_start_button_down() -> void:
	Metronome.turn_on()
	for test_tempo in test_tempos:
		var directory_path: String = voice_path + test_tempo
		var tempo: int = int(test_tempo.trim_suffix("/"))
		await test_directories(directory_path, tempo)
	Metronome.turn_off()
