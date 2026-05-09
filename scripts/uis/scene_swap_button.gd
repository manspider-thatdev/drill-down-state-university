class_name SceneSwapButton
extends Button


@export var scene: StringName
@export var use_past_scene := false


func _ready() -> void:
	button_down.connect(_on_button_down)


func _on_button_down() -> void:
	Metronome.turn_off()
	SceneChanger.change_scene(scene)


func set_scene_data(old_scene: StringName) -> void:
	if use_past_scene and not old_scene.is_empty():
		scene = old_scene
