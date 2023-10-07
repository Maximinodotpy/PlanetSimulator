extends PopupMenu

const DELETE = 'Delete'
const DELETE_INDEX = 0

const STOP = 'Stop'
const STOP_INDEX = 1

const ALIGN = 'Align'
const ALIGN_INDEX = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	var alignMenu = PopupMenu.new()
	alignMenu.name = 'align'
	alignMenu.set_script(load("res://Scenes/User Interface/Editor/MenuScripts/EditAlignMenu.gd"))
	add_child(alignMenu)


	add_item(DELETE, DELETE_INDEX)
	add_item(STOP, STOP_INDEX)

	add_submenu_item(ALIGN, 'align', ALIGN_INDEX)

	index_pressed.connect(indexPressed)
	EditorGlobal.anything_changed.connect(react)
	react()

func indexPressed(index: int):
	match get_item_text(index):
		DELETE: EditorGlobal.delete_selected()
		STOP: EditorGlobal.stop_selected()

func react():
	## Disable align menu if no nodes are selected
	set_item_disabled(ALIGN_INDEX, EditorGlobal.is_empty_selection())

	## Disable delete menu if no nodes are selected
	set_item_disabled(DELETE_INDEX, EditorGlobal.is_empty_selection())

	## Disable stop menu if no nodes are selected
	set_item_disabled(STOP_INDEX, EditorGlobal.is_empty_selection())
