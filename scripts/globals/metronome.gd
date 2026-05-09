extends AudioStreamPlayer2D


signal beat()

@export var bpm: int = 100

var is_on := false
var beat_length: float:
	get():
		return 60 / float(bpm)


func turn_on() -> void:
	if is_on:
		return
	is_on = true
	sound_loop()


func turn_off() -> void:
	is_on = false


func toggle(value: bool) -> void:
	var was_on = is_on
	is_on = value
	if not was_on and is_on:
		sound_loop()


func sound_loop() -> void:
	if not is_on:
		return
	
	play()
	beat.emit()
	
	await get_tree().create_timer(beat_length).timeout
	sound_loop() 
