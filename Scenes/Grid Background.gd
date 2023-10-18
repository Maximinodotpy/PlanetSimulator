extends ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _ready():
	UserInterface.on_toggle_background_grid.connect(toggle_visibility)
	visible = UserInterface.get_config_value('background_grid_visible', true)

func toggle_visibility():
	visible = not visible
	UserInterface.set_config_value('background_grid_visible', visible)
