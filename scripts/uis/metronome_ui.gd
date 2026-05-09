extends Control


@onready var play_button: Button = $HBoxContainer/PlayButton
@onready var bpm_label: Label = $HBoxContainer/BPMLabel

@export var bpm: int = 100:
	set = set_bpm
@export var minimum_bpm: int = 60
@export var maximum_bpm: int = 280
@export var bpm_step: int = 5

var is_testing_metronome := false
var beat_length: float:
	get():
		return 60 / float(bpm)


func _ready() -> void:
	set_bpm(bpm)


func set_bpm(value: int) -> void:
	bpm = clampi(value, minimum_bpm, maximum_bpm)
	bpm_label.text = str(bpm) + "bpm"
	Metronome.bpm = bpm


func _on_up_button_down() -> void:
	bpm += bpm_step


func _on_down_button_down() -> void:
	bpm -= bpm_step


func _on_play_button_toggled(toggled_on: bool) -> void:
	play_button.text = str(int(toggled_on))
	Metronome.toggle(toggled_on)
