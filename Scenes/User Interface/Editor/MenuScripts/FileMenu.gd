extends PopupMenu
# Called when the node enters the scene tree for the first time.
func _ready():
	index_pressed.connect(callback)
func callback(id: int):
	var item_text = get_item_text(id)
	if item_text == 'Save':

		if EditorSaves.currentSaveName == '':
			EditorGlobal.get_file_name_edit().grab_focus()
		else:
			EditorSaves.save_file()

	if item_text == 'Exit':
		EditorSaves.currentSaveName = ''
		EditorGlobal.clear_selection()
		get_tree().change_scene_to_file("res://Scenes/User Interface/Main.tscn")
