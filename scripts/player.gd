class_name Player
extends Node3D


enum {
	NORTH,
	EAST,
	SOUTH,
	WEST,
}

enum {
	BACKWARD = -2,
	LEFT = -1,
	FORWARD = 0,
	RIGHT = 1,
}

const DIRECTIONS: Array[Vector3] = [
	Vector3.FORWARD,
	Vector3.RIGHT,
	Vector3.BACK,
	Vector3.LEFT,
]

@export var slide_speed: float = 5.0

var facing: int = NORTH:
	set(value):
		facing = wrapi(value, NORTH, WEST + 1)

var direction: int = FORWARD
var is_moving: bool = false


func _process(delta: float) -> void:
	if is_moving:
		position += DIRECTIONS[wrapi(facing + direction, 0, 4)] * slide_speed * delta


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("forward"):
		direction = FORWARD
		is_moving = true
	elif event.is_action_pressed("backward"):
		direction = BACKWARD
		is_moving = true
	elif event.is_action_pressed("right slide"):
		direction = RIGHT
		is_moving = true
	elif event.is_action_pressed("left slide"):
		direction = LEFT
		is_moving = true
	elif event.is_action_pressed("attention"):
		direction = FORWARD
		is_moving = false
	if event.is_action_pressed("left flank"):
		rotate_y(PI/2)
		facing += LEFT
		direction = FORWARD
		is_moving = true
	elif event.is_action_pressed("right flank"):
		rotate_y(-PI/2)
		facing += RIGHT
		direction = FORWARD
		is_moving = true
	elif event.is_action_pressed("to the rear"):
		rotate_y(PI)
		facing += BACKWARD
		direction = FORWARD
		is_moving = true
