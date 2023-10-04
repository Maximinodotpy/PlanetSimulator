extends "res://Scenes/User Interface/Editor/Tools/Tool Template.gd"

var selectBox: ColorRect
var currenSelectionRect = Rect2(0,0,0,0)

func _init():
	tool_name = 'Select'
	shortcut_key = KEY_V

func selected():
	selectBox = ColorRect.new()

	selectBox.mouse_filter = Control.MOUSE_FILTER_IGNORE

	selectBox.size = Vector2(0, 0)
	selectBox.position = Vector2(0, 0)

	selectBox.color = Color(0.20392157137394, 0.21960784494877, 0.29803922772408, 0.74117648601532)

	viewport.add_child(selectBox)

func dragStart(startPos):
	selectBox.position = startPos

func dragging(startPos, currentPos):
	currenSelectionRect = Rect2(
		min(startPos.x, currentPos.x),
		min(startPos.y, currentPos.y),
		abs(startPos.x - currentPos.x),
		abs(startPos.y - currentPos.y),
	)

	selectBox.position = currenSelectionRect.position
	selectBox.size = currenSelectionRect.size

func dragEnd(starPos, endPos):
	selectBox.size = Vector2(0, 0)
	selectBox.position = Vector2(0, 0)

	print('Select Finished')

	if Input.is_key_pressed(KEY_SHIFT):
		pass
	else:
		EditorGlobal.clear_selection()

	for planet in viewport.get_tree().get_nodes_in_group('gravity_object'):
		if currenSelectionRect.has_point(planet.position):
			EditorGlobal.add_to_selection(planet)

func unselected():
	selectBox.queue_free()
