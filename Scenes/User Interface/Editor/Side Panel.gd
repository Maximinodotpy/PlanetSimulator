extends VSplitContainer

func _ready():
	EditorGlobal.toggle_side_panel.connect(toggle)

func toggle():
	visible = !visible
