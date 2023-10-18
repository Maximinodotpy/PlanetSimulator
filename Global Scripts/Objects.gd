extends Node


signal on_object_added(node: Node2D)
signal on_object_removed(node: Node2D)
signal on_object_renamed(node: Node2D)

var planetScene = preload("res://Scenes/Planet/Planet.tscn")


func get_all_objects():
	var objects = get_tree().get_nodes_in_group('gravity_object')

	var return_objs = []

	for i in objects:
		if not i.is_queued_for_deletion():
			return_objs.append(i)

	return return_objs

func is_there_objects() -> bool:
	return get_all_objects().size() > 0

func remove_object(node: Node2D):
	Selection.remove_from_selection(node)
	node.queue_free()
	EditorGlobal.anything_changed.emit()
	on_object_removed.emit(node)

func add_object():
	var grav_obj: Planet = planetScene.instantiate()
	EditorGlobal.get_space().add_child(grav_obj)
	grav_obj.set_name('Planet ')
	EditorGlobal.anything_changed.emit()
	on_object_added.emit(grav_obj)
	return grav_obj

func rename_object(object: Node2D, new_name: String):
	object.name = new_name
	EditorGlobal.anything_changed.emit()
	on_object_renamed.emit()
