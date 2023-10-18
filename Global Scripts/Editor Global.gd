extends Node

## Global Editor Functions for the Selection and Loading Files

var simulationSpeed: int = 1

var focused_object: Node2D

const MIN_SIMULATION_SPEED = 1
const DEFAULT_SIMULATION_SPEED = 10
const MAX_SIMULATION_SPEED = 250

var planetScene = preload("res://Scenes/Planet/Planet.tscn")

## This is called when
## The Selection Changes
## An Object is added or removed
signal anything_changed


enum OBJECT_TYPES {
	Planet,
	Ship
}


func _ready():
	Selection.selection_changed.connect(callAnythingChanged)

func callAnythingChanged():
	anything_changed.emit()

func is_there_objects() -> bool:
	return get_all_objects().size() > 0

func remove_object(node: Node2D):
	Selection.remove_from_selection(node)
	node.queue_free()
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
