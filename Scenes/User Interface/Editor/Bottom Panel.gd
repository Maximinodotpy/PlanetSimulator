extends MarginContainer


func _ready():
	EditorGlobal.toggle_status_bar.connect(toggle)

func toggle():
	visible = !visible
