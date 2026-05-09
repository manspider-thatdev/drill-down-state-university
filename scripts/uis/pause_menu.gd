extends Control


func _ready() -> void:
	visible = false


func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("pause"):
		return
	
	if get_tree().paused:
		unpause()
	else:
		pause()


func pause() -> void:
	Metronome.pause()
	get_tree().paused = true
	visible = true


func unpause() -> void:
	Metronome.unpause()
	get_tree().paused = false
	visible = false


func _on_resume_button_down() -> void:
	unpause()


func _on_back_button_down() -> void:
	unpause()
