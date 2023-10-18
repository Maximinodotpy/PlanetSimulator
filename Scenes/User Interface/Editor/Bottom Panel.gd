extends MarginContainer


func _ready():
	UserInterface.on_toggle_status_bar.connect(toggle)

func toggle():
	visible = !visible
