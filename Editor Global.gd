extends Node

## Global Editor Functions for the Selection and Loading Files

var selection = []
var simulationSpeed = 1

var planetScene = preload("res://Scenes/Planet/Planet.tscn")

signal selection_changed

## This is called when
## The Selection Changes
## An Object is added or removed
signal anything_changed


enum OBJECT_TYPES {
	Planet,
	Ship
}


func _ready():
	var callAnythingChanged = func():
		anything_changed.emit()

	connect('selection_changed', callAnythingChanged)

func get_selection():
	return selection

func select_all():
	for object in get_tree().get_nodes_in_group('gravity_object'):
		add_to_selection(object)

func add_to_selection(node: Node):
	if node not in get_selection():
		selection.append(node)

	selection_changed.emit()

func clear_selection():
	selection.clear()

	selection_changed.emit()

func remove_from_selection(node: Node2D):
	if node in get_selection():
		get_selection().erase(node)

func get_selection_rect() -> Rect2:
	var rect = Rect2()

	if get_selection().size() > 0:
		var firstItem = get_selection()[0]
		rect.position = firstItem.position

	for i in get_selection():
		rect = rect.expand(i.position)

	return rect

func get_selection_bounding_rect() -> Rect2:
	var rect = Rect2()

	if get_selection().size() > 0:
		var firstItem = get_selection()[0]
		rect.position = firstItem.position

	for i in get_selection():
		rect = rect.expand(i.position)

		var calcRadi = i.weight * 5

		rect = rect.expand(i.position + Vector2(calcRadi, 0))
		rect = rect.expand(i.position + Vector2(0, calcRadi))
		rect = rect.expand(i.position - Vector2(calcRadi, 0))
		rect = rect.expand(i.position - Vector2(0, calcRadi))

	return rect

func delete_selected():
	for object in get_selection():
		remove_object(object)

	selection_changed.emit()

func move_selected_to(target_pos: Vector2):
	var offset = target_pos - get_selection_rect().position

	for object in get_selection():
		object.position += offset

func stop_selected():
	for object in get_selection():
		object.motion = Vector2.ZERO

func align_selection_left():
	for object in get_selection():
		object.position.x = get_selection_rect().position.x

func align_selection_right():
	for object in get_selection():
		object.position.x = get_selection_rect().position.x + get_selection_rect().size.x

func align_selection_top():
	for object in get_selection():
		object.position.y = get_selection_rect().position.y

func align_selection_bottom():
	for object in get_selection():
		object.position.y = get_selection_rect().position.y + get_selection_rect().size.y

func center_selection_vertically():
	var yCenter = get_selection_rect().position.y + (get_selection_rect().size.y / 2)

	for object in get_selection():
		object.position.y = yCenter

func center_selection_horizontaly():
	var xCenter = get_selection_rect().position.x + (get_selection_rect().size.x / 2)

	for object in get_selection():
		object.position.x = xCenter


func remove_object(node: Node2D):
	remove_from_selection(node)
	node.free()
	anything_changed.emit()

func add_object(type: OBJECT_TYPES):
	print('Adding Planet')

	var grav_obj: Planet = planetScene.instantiate()

	get_space().add_child(grav_obj)

	anything_changed.emit()

	return grav_obj

func rename_object(object: Node2D, new_name: String):
	object.name = new_name
	anything_changed.emit()


func get_space() -> Node2D:
	return Helpers.getSceneRoot().find_children('space')[0]

func get_space_viewport() -> SubViewport:
	return Helpers.getSceneRoot().find_children('space_viewport')[0]


func load_file():
	pass

func save_file():
	pass
