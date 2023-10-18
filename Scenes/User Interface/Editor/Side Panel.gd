extends VSplitContainer

func _ready():
	UserInterface.on_toggle_side_panel.connect(toggle)

func toggle():
	visible = !visible
