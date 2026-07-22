class_name ListPattern
extends Pattern


@export var commands: Array[Commands.States]


func create_queue(states: Array[int]) -> Array[int]:
	var queue: Array[int] = []
	for command in commands:
		queue.append(command)
	
	states.append_array(queue)
	return states
