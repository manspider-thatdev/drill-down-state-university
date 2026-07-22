class_name PickPattern
extends Pattern


@export var min_patterns: int = 2
@export var max_patterns: int = 5


func create_queue(states: Array[int]) -> Array[int]:
	var patterns: Array = get_children()
	
	var pattern_count := randi_range(min_patterns, max_patterns)
	for i in range(pattern_count):
		var pattern: Pattern = patterns.pick_random()
		states = pattern.create_queue(states)
	
	return states
