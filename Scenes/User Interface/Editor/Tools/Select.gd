extends "res://Scenes/User Interface/Editor/Tools/Tool Template.gd"

var selectBox: Panel
var currenSelectionRect = Rect2(0,0,0,0)
var moveOffset : Vector2

func _init():
	tool_name = 'Select'
	shortcut_key = KEY_V
	tool_icon = preload("res://Theme/Icons/mouse-pointer-square-dashed.svg")

func selected():
	selectBox = Panel.new()

	selectBox.add_theme_stylebox_override('panel', EditorGlobal.createStyleBox(
		Color(0.45191067457199, 0.47775673866272, 0.60222572088242, 0.74117648601532)
	))

	selectBox.mouse_filter = Control.MOUSE_FILTER_IGNORE

	selectBox.size = Vector2(0, 0)
	selectBox.position = Vector2(0, 0)

	viewport.add_child(selectBox)

func dragStart(startPos):
	print('Selection Started')
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

func selectionDragStart(startPos):
	moveOffset = EditorGlobal.get_selection_rect().position - startPos
	print('moveOffset', moveOffset)

func selectionDragging(startPos, currentPos):
	var targetPos = currentPos + moveOffset

	if Input.is_key_pressed(KEY_SHIFT):
		targetPos = targetPos.snapped(Vector2(100, 100))
	elif Input.is_key_pressed(KEY_CTRL):
		targetPos = targetPos.snapped(EditorGlobal.get_selection_bounding_rect().size)

	EditorGlobal.move_selected_to(targetPos)

func unselected():
	selectBox.queue_free()
