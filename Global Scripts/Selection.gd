extends Node

var selection = []

signal selection_changed

## State Queries

func is_empty_selection() -> bool:
	return get_selection().size() == 0

func is_single_selection() -> bool:
	return get_selection().size() == 1

func is_multi_selection() -> bool:
	return get_selection().size() > 1

func is_all_selected() -> bool:
	return get_selection().size() == Objects.get_all_objects().size()

# Getting the Current Selection
func get_selection():
	return selection

# Modifiying the Selection
func select_all():
	for object in get_tree().get_nodes_in_group('gravity_object'):
		add_to_selection(object)

	selection_changed.emit()

func swap_selection(new_nodes: Array[Node2D]):
	for old_node in get_selection():
		if old_node not in new_nodes:
			remove_from_selection(old_node)

	for new_node in new_nodes:
		if new_node not in get_selection():
			add_to_selection(new_node)

func add_one_random_to_selection():
	var objects = EditorGlobal.get_all_objects()

	if objects.size() > 0:
		var randomIndex = randi() % objects.size()
		add_to_selection(objects[randomIndex])

	selection_changed.emit()

func add_to_selection(node: Node):
	if node not in get_selection():
		selection.append(node)

		selection_changed.emit()

func clear_selection():
	var preSelection = get_selection().duplicate()
	selection.clear()
	if not preSelection.is_empty():
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


# Selection Rects

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


# Modifying Selected Elements

func delete_selected():
	for object in get_selection().duplicate():
		Objects.remove_object(object)

	EditorGlobal.anything_changed.emit()

func move_selected_to(target_pos: Vector2):
	var offset = target_pos - get_selection_rect().position

	for object in get_selection():
		object.position += offset

	EditorGlobal.anything_changed.emit()

func set_weight_for_each_selected(weight: int):
	print('Setting Weight to "%s"' % weight)
	for object in get_selection():
		object.weight = weight
	EditorGlobal.anything_changed.emit()

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
