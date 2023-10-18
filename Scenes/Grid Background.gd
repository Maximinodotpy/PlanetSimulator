extends ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _ready():
	UserInterface.on_toggle_background_grid.connect(toggle_visibility)

func toggle_visibility():
	visible = not visible
