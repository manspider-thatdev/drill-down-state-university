class_name ConditionalPattern
extends Pattern


@export var condition: Commands.States


func create_queue(states: Array[int]) -> Array[int]:
	var pattern: Pattern = get_child(0)
	if states[-1] == condition:
		return pattern.create_queue(states)
	return states
