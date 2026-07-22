class_name SequencePattern
extends Pattern


func create_queue(states: Array[int]) -> Array[int]:
	var patterns: Array = get_children()
	for pattern in patterns:
		pattern.create_queue(states)
	return states
