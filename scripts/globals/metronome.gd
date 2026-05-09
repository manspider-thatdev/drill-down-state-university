extends AudioStreamPlayer2D


signal beat()

@onready var timer: Timer = $Timer

@export var bpm: int = 120

var is_on := false
var beat_length: float:
	get():
		return 60 / float(bpm)
var loop_active := false


func turn_on() -> void:
	if is_on:
		return
	is_on = true
	timer.start(beat_length)
	if not loop_active:
		sound_loop()


func turn_off() -> void:
	is_on = false
	timer.stop()


func toggle(value: bool) -> void:
	var was_on = is_on
	is_on = value
	if not was_on and is_on:
		if not loop_active:
			sound_loop()
		timer.start(beat_length)
	else:
		timer.stop()


func pause() -> void:
	timer.paused = true


func unpause() -> void:
	timer.paused = false


func sound_loop() -> void:
	if not is_on:
		loop_active = false
		return
	loop_active = true
	
	play()
	beat.emit()
	
	await timer.timeout
	timer.wait_time = beat_length
	sound_loop() 
