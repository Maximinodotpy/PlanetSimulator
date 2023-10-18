extends MarginContainer


func _ready():
	visible = UserInterface.get_config_value('bottom_panel_visible', true)
	UserInterface.on_toggle_status_bar.connect(toggle)

func toggle():
	visible = !visible
	UserInterface.set_config_value('bottom_panel_visible', visible)
