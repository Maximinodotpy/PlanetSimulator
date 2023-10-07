extends PopupMenu

const SELECT_ALL = 'Select All'
const SELECT_ALL_INDEX = 0

const INVERSE_SELECTION = 'Inverse Selection'
const INVERSE_SELECTION_INDEX = 1

const UNSELECT_ALL = 'Unselect All'
const UNSELECT_ALL_INDEX = 2

const RANDOM = 'Random'
const RANDOM_INDEX = 3

const SELECT_ONE_RANDOMLY = 'Select One Randomly'
const SELECT_ONE_RANDOMLY_INDEX = 4

const SELECT_MANY_RANDOMLY = 'Select Many Randomly'
const SELECT_MANY_RANDOMLY_INDEX = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	add_item(SELECT_ALL, SELECT_ALL_INDEX)
	add_item(INVERSE_SELECTION, INVERSE_SELECTION_INDEX)
	add_item(UNSELECT_ALL, UNSELECT_ALL_INDEX)

	add_separator(RANDOM, RANDOM_INDEX)

	add_item(SELECT_ONE_RANDOMLY, SELECT_ONE_RANDOMLY_INDEX)
	add_item(SELECT_MANY_RANDOMLY, SELECT_MANY_RANDOMLY_INDEX)

	index_pressed.connect(indexPressed)

	EditorGlobal.anything_changed.connect(react)

	react()

func indexPressed(index: int):
	match get_item_text(index):
		SELECT_ALL: EditorGlobal.select_all()
		INVERSE_SELECTION: EditorGlobal.inverse_selection()
		UNSELECT_ALL: EditorGlobal.clear_selection()
		SELECT_ONE_RANDOMLY:
			EditorGlobal.clear_selection()
			EditorGlobal.add_one_random_to_selection()

		SELECT_MANY_RANDOMLY:
			EditorGlobal.clear_selection()

			## Get Random Amount of objects
			var amount = randi_range(1, EditorGlobal.get_all_objects().size())

			for i in range(amount):
				EditorGlobal.add_one_random_to_selection()

func react():
	set_item_disabled(
		SELECT_ALL_INDEX,
		EditorGlobal.is_all_selected(),
	)

	set_item_disabled(
		INVERSE_SELECTION_INDEX,
		EditorGlobal.is_empty_selection() or EditorGlobal.is_all_selected(),
	)

	set_item_disabled(
		UNSELECT_ALL_INDEX,
		EditorGlobal.is_empty_selection(),
	)

	set_item_disabled(
		SELECT_ONE_RANDOMLY_INDEX,
		not EditorGlobal.is_there_objects(),
	)

	set_item_disabled(
		SELECT_MANY_RANDOMLY_INDEX,
		not EditorGlobal.is_there_objects(),
	)
