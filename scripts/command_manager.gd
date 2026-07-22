class_name CommandManager
extends Node


signal command_selected(command: int)


@onready var control_pattern: ControlPattern = $"../ControlPattern"


var rng := RandomNumberGenerator.new()

var state: int = Commands.PARADE_REST:
	set(value):
		if Commands.DELAYS.has(value) and not Commands.DELAYS.has(state):
			past_state = state
		state = value

var past_state: int = Commands.PARADE_REST
var horns_are_up := false

var command_queue: Array[int] = []

var beat_count: int = 4:
	set(value):
		beat_count = wrapi(value, 1, 5)


func _ready() -> void:
	Metronome.beat.connect(_on_metronome_beat)


func _on_metronome_beat() -> void:
	beat_count += 1
	if beat_count != 1:
		#print(beat_count)
		return
	
	var command: int
	command = select_command()
	
	if command == Commands.PARADE_REST and not horns_are_up:
		state = Commands.PARADE_REST
	
	elif command == Commands.ATTENTION or command == Commands.DETAIL_HALT:
		state = Commands.ATTENTION
	
	elif Commands.FLANKS.has(command):
		state = Commands.FORWARDS_MARCH
	
	elif command == Commands.BAND_HORNS:
		horns_are_up = !horns_are_up
	
	elif command == Commands.NOTHING and Commands.DELAYS.has(state):
		state = past_state
	
	elif command != Commands.NOTHING:
		state = command
	
	command_selected.emit(command)
	#print(beat_count, Commands.TO_STRING[command], Commands.TO_STRING[state], horns_are_up)


func select_command() -> int:
	if not command_queue.is_empty():
		return command_queue.pop_front()
	
	command_queue = control_pattern.create_queue()
	
	return command_queue.pop_front()
