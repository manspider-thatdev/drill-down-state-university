class_name RandomPattern
extends Pattern


@export var min_commands: int = 3
@export var max_commands: int = 10

@export var commands: Array[Commands.States]
@export var random_matrix: Array[Array]


func create_queue(states: Array[int]) -> Array[int]:
	var rng := RandomNumberGenerator.new()
	var last_command: int = commands[0]
	if states.size() > 0 and commands.has(states[-1]):
		last_command = states[-1]
	
	var queue: Array[int] = []
	var command_count := randi_range(min_commands, max_commands)
	var command_index: int = commands.find(last_command)
	
	for i in range(command_count):
		command_index = rng.rand_weighted(random_matrix[command_index])
		var next_command = commands[command_index]
		queue.append(next_command)
		last_command = next_command
	
	states.append_array(queue)
	return states
