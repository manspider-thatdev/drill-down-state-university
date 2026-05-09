class_name CommandManager
extends Node


signal command_selected(command: int)

@export var patterns: Array[CommandPattern] = []

var state: int = Commands.PARADE_REST
var motion_state: int = Commands.PARADE_REST
var horns_are_up := false

var pattern: CommandPattern = null
var command_length: int = 0

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
	
	if state == Commands.LEFT_DELAY or state == Commands.RIGHT_DELAY or state == Commands.ABOUT_DELAY:
		state = motion_state
	
	if command == Commands.PARADE_REST and not horns_are_up:
		state = Commands.PARADE_REST
		motion_state = Commands.PARADE_REST
		
	elif command == Commands.ATTENTION or command == Commands.DETAIL_HALT:
		state = Commands.ATTENTION
		motion_state = Commands.ATTENTION
		
	elif command == Commands.MARK_TIME:
		state = Commands.MARK_TIME
		motion_state = Commands.MARK_TIME
		
	elif command == Commands.LEFT_DELAY:
		state = Commands.LEFT_DELAY
		
	elif command == Commands.RIGHT_DELAY:
		state = Commands.RIGHT_DELAY
		
	elif command == Commands.ABOUT_DELAY:
		state = Commands.ABOUT_DELAY
		
	elif (command == Commands.FORWARDS_MARCH or command == Commands.LEFT_FLANK 
			or command == Commands.RIGHT_FLANK or command == Commands.TO_THE_REAR):
		state = Commands.FORWARDS_MARCH
		motion_state = Commands.FORWARDS_MARCH
		
	elif command == Commands.BACKWARDS_MARCH:
		state = Commands.BACKWARDS_MARCH
		motion_state = Commands.BACKWARDS_MARCH
		
	elif command == Commands.LEFT_SLIDE:
		state = Commands.LEFT_SLIDE
		motion_state = Commands.LEFT_SLIDE
		
	elif command == Commands.RIGHT_SLIDE:
		state = Commands.RIGHT_SLIDE
		motion_state = Commands.RIGHT_SLIDE
		
	elif command == Commands.BAND_HORNS:
		horns_are_up = !horns_are_up
	
	command_selected.emit(command)
	#print(beat_count, Commands.TO_STRING[command], Commands.TO_STRING[state], horns_are_up)


func select_command() -> int:
	if command_length == 0:
		pattern = patterns.pick_random()
		command_length = randi_range(pattern.min_length, pattern.max_length)
	
	var filtered_commands: Array = Commands.ALLOWED[state].filter(
		func(command: int) -> bool: return pattern.commands.has(command))
	
	var selected_command: int
	if (filtered_commands.is_empty() or 
			filtered_commands.all(
				func(command: int) -> bool: 
					return [Commands.NOTHING, Commands.BAND_HORNS].has(command))):
		if state == Commands.PARADE_REST:
			selected_command = Commands.ATTENTION
		else:
			selected_command = Commands.DETAIL_HALT
	else:
		selected_command = filtered_commands.pick_random()
	
	command_length -= 1
	return selected_command
