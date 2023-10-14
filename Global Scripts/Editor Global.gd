extends Node

## Global Editor Functions for the Selection and Loading Files

var selection = []

var simulationSpeed: int = 1

var focused_object: Node2D

const MIN_SIMULATION_SPEED = 1
const DEFAULT_SIMULATION_SPEED = 10
const MAX_SIMULATION_SPEED = 250

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
	connect('selection_changed', callAnythingChanged)

func callAnythingChanged():
	anything_changed.emit()

func is_empty_selection() -> bool:
	return get_selection().size() == 0

func is_single_selection() -> bool:
	return get_selection().size() == 1

func is_multi_selection() -> bool:
	return get_selection().size() > 1

func is_all_selected() -> bool:
	return get_selection().size() == get_all_objects().size()

func is_there_objects() -> bool:
	return get_all_objects().size() != 0

func get_selection():
	return selection

func select_all():
	for object in get_tree().get_nodes_in_group('gravity_object'):
		add_to_selection(object)
	selection_changed.emit()

func add_one_random_to_selection():
	var objects = get_all_objects()

	if objects.size() > 0:
		var randomIndex = randi() % objects.size()
		add_to_selection(objects[randomIndex])

	selection_changed.emit()

func add_to_selection(node: Node):
	if node not in get_selection():
		selection.append(node)

	selection_changed.emit()

func clear_selection():
	selection.clear()
	selection_changed.emit()

func inverse_selection():
	var newSel = []

	for other_object in get_tree().get_nodes_in_group('gravity_object'):
		if other_object not in get_selection():
			newSel.append(other_object)

	clear_selection()

	for object in newSel:
		add_to_selection(object)

	selection_changed.emit()

func remove_from_selection(node: Node2D):
	if node in get_selection():
		get_selection().erase(node)
	selection_changed.emit()

func get_selection_rect() -> Rect2:
	var rect = Rect2()

	if get_selection().size() > 0:
		if not get_selection()[0].is_queued_for_deletion():
			var firstItem: Node = get_selection()[0]
			if firstItem:
				rect.position = firstItem.position

	for i in get_selection():
		rect = rect.expand(i.position)

	return rect

func get_selection_bounding_rect() -> Rect2:
	var rect = Rect2()

	if get_selection().size() > 0:
		if not get_selection()[0].is_queued_for_deletion():
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

	anything_changed.emit()

func set_weight_for_each_selected(weight: int):
	print('Setting Weight to "%s"' % weight)
	for object in get_selection():
		object.weight = weight
	anything_changed.emit()

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

func add_object(_type: OBJECT_TYPES):
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

func get_space_viewport() -> Viewport:
	return Helpers.getSceneRoot().find_children('space_viewport')[0]

func get_file_name_edit() -> LineEdit:
	return Helpers.getSceneRoot().find_children('File Name Edit')[0]

func get_all_objects():
	var objects = get_tree().get_nodes_in_group('gravity_object')

	var return_objs = []

	for i in objects:
		if i.name != 'Space Ship':
			pass
		return_objs.append(i)

	return return_objs


func get_simulation_speed() -> int:
	return simulationSpeed

func set_simulation_speed(speed: int):
	simulationSpeed = clamp(speed, MIN_SIMULATION_SPEED, MAX_SIMULATION_SPEED)
	anything_changed.emit()

func reset_simulation_speed():
	simulationSpeed = DEFAULT_SIMULATION_SPEED

func is_simulation_slowest() -> bool:
	return simulationSpeed == MIN_SIMULATION_SPEED

func is_simulation_fastest() -> bool:
	return simulationSpeed == MAX_SIMULATION_SPEED

func pause_simulation():
	get_tree().paused = true
	anything_changed.emit()

func resume_simulation():
	get_tree().paused = false
	anything_changed.emit()

func simulation_fastest():
	simulationSpeed = MAX_SIMULATION_SPEED
	anything_changed.emit()

func simulation_slowest():
	simulationSpeed = MIN_SIMULATION_SPEED
	anything_changed.emit()

func createStyleBox(color: Color):
	var styleBox = StyleBoxFlat.new()
	styleBox.set_border_width_all(2)
	styleBox.border_color = color.darkened(0.3)
	styleBox.bg_color = color
	return styleBox

func createShortcut(letter: int, ctrl: bool = false, shift: bool = false):
	var shortcut = Shortcut.new()

	var inputEvent = InputEventKey.new()

	inputEvent.ctrl_pressed = ctrl
	inputEvent.shift_pressed = shift

	inputEvent.keycode = letter

	shortcut.events = [ inputEvent ]

	return shortcut

func focusObject(node: Node2D):
	focused_object = node
	anything_changed.emit()

func getFocusedObject():
	return focused_object

func unfocus():
	focused_object = null
	anything_changed.emit()
