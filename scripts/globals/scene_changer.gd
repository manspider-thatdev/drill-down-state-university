extends Control


var old_scene: StringName = ""
var current_scene: StringName = ""


func change_scene(new_scene: StringName) -> void:
	if not current_scene.is_empty():
		old_scene = current_scene
	
	get_tree().change_scene_to_file(new_scene)
	
	current_scene = new_scene
	
	await get_tree().process_frame
	await get_tree().process_frame
	
	for scene_observer in get_tree().get_nodes_in_group("scene_observer"):
		scene_observer.set_scene_data(old_scene)
