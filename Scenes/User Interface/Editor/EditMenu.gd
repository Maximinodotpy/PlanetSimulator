extends PopupMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

	var alignMenu = PopupMenu.new()
	alignMenu.name = 'align'

	alignMenu.add_item('Align Left')

	add_child(alignMenu)

	add_submenu_item('Align', 'align')


	index_pressed.connect(indexPressed)
	EditorGlobal.anything_changed.connect(react)
	react()

func indexPressed(index: int):
	match get_item_text(index):
		'fasd': pass

func react():
	pass
