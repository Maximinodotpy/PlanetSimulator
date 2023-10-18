extends VSplitContainer

func _ready():
	visible = UserInterface.get_config_value('side_panel_visibility', true)

	var ind = UserInterface.get_config_value('side_panel_position', 0)

	if ind == 1:
		var timer = get_tree().create_timer(-1)
		timer.timeout.connect(toggle_position)

	UserInterface.on_toggle_side_panel.connect(toggle)
	UserInterface.on_toggle_side_panel_position.connect(toggle_position)

func toggle():
	visible = !visible
	UserInterface.set_config_value('side_panel_visibility', visible)


func toggle_position():
	if get_index() == 1:
		get_parent().move_child(self, 0)
	else:
		get_parent().move_child(self, 1)

	UserInterface.set_config_value('side_panel_position', get_index())
