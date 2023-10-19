extends HSplitContainer


func _ready():
	dragged.connect(split_dragged)
	UserInterface.on_toggle_side_panel_position.connect(mirror, CONNECT_DEFERRED)

	split_offset = UserInterface.get_config_value('main_split_offset', 500)


func split_dragged(offset: int):
	UserInterface.set_config_value('main_split_offset', offset)


func mirror():
	print('Mirrored')
	print('split_offset', split_offset)
	print(get_children())

	if get_children()[0].name == 'Side Panel':
		split_offset = absi(split_offset)
	else:
		split_offset = -split_offset

	UserInterface.set_config_value('main_split_offset', split_offset)
