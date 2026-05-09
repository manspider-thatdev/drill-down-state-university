class_name CommandPattern
extends Resource


@export_range(1, 30, 1, "or_greater") var min_length: int = 3
@export_range(1, 30, 1, "or_greater") var max_length: int = 10
@export var commands: Array[Commands.States] = []
