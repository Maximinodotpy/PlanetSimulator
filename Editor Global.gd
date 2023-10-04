extends Node

var selection = []

signal selection_change

func get_selection():
	return selection

func add_to_selection(node: Node):
	if node not in get_selection():
		selection.append(node)

func clear_selection():
	selection.clear()

func remove_from_selection():
	pass

func get_selection_rect() -> Rect2:
	var rect = Rect2()

	if get_selection().size() > 0:
		var firstItem = get_selection()[0]
		rect.position = firstItem.position

	for i in get_selection():
		rect = rect.expand(i.position)

	if get_selection().size() > 0:
		rect = rect.grow(100)

	return rect

func delete_selected():
	for i in get_selection():
		i.queue_free()

	clear_selection()


func get_space() -> Node2D:
	return Helpers.getSceneRoot().find_children('space')[0]

func get_space_viewport() -> SubViewport:
	return Helpers.getSceneRoot().find_children('space_viewport')[0]


func load_file():
	pass

func save_file():
	pass
