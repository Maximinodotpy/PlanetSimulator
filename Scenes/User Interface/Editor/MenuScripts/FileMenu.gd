extends PopupMenu


const SAVE = 'Save'
const SAVE_INDEX = 0
var SAVE_SHORCUT = EditorGlobal.createShortcut(KEY_S, true)

const QUIT = 'Quit'
const QUIT_INDEX = 1
var QUIT_SHORTCUT = EditorGlobal.createShortcut(KEY_Q, true)

func _ready():
	add_item(SAVE, SAVE_INDEX)
	set_item_shortcut(SAVE_INDEX, SAVE_SHORCUT)

	add_item(QUIT, QUIT_INDEX)
	set_item_shortcut(QUIT_INDEX, QUIT_SHORTCUT)

	index_pressed.connect(callback)

func callback(id: int):

	match id:
		SAVE_INDEX:
			print('Pressed Save Button')

			if EditorSaves.currentSaveName == '':
				var giveNamePopup = ConfirmationDialog.new()
				giveNamePopup.dialog_text = 'Please give your file a name before Saving.'
				giveNamePopup.show()
				get_viewport().add_child(giveNamePopup)
				giveNamePopup.popup_centered()

				giveNamePopup.confirmed.connect(EditorGlobal.get_file_name_edit().grab_focus)
			else:
				EditorSaves.started_saving.emit()

				EditorSaves.call_deferred('save_file')

		QUIT_INDEX:
			EditorSaves.currentSaveName = ''
			EditorGlobal.clear_selection()
			get_tree().change_scene_to_file("res://Scenes/User Interface/Main.tscn")


#	if item_text == 'Exit':
#	if item_text == 'Save':
#
#
