class_name ControlPattern
extends Pattern


@onready var stationary_pattern: Pattern = $StationaryPattern
@onready var forward_pattern: Pattern = $ForwardPattern
@onready var delay_pattern: Pattern = $DelayPattern
@onready var flank_pattern: Pattern = $FlankPattern
@onready var random_pattern: Pattern = $RandomPattern

var index: int = -1


func create_queue(states: Array[int] = []) -> Array[int]:
	index += 1
	if index == 0:
		return stationary_pattern.create_queue(states)
	elif index == 1:
		return forward_pattern.create_queue(states)
	elif index == 20:
		return stationary_pattern.create_queue(states)
	
	var patterns: Array[Pattern] = [
		forward_pattern, 
		delay_pattern, 
		flank_pattern, 
		random_pattern,
	]
	
	return patterns.pick_random().create_queue(states)
