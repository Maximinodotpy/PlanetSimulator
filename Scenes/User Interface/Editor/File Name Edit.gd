extends LineEdit

func _ready():
	text = EditorSaves.currentSaveName
	text_submitted.connect(text_suggested)
func text_suggested(new_text: String):
	if not new_text in EditorSaves.get_all_save_names() or EditorSaves.currentSaveName == new_text:
		print(new_text)

		## TODO Rename old SAave
		EditorSaves.currentSaveName = new_text
		release_focus()
