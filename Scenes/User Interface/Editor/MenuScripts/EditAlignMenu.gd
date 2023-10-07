extends PopupMenu

const ALIGN_LEFT = 'Left'
const ALIGN_LEFT_INDEX = 0

const ALIGN_RIGHT = 'Right'
const ALIGN_RIGHT_INDEX = 0

const ALIGN_TOP = 'Top'
const ALIGN_TOP_INDEX = 0

const ALIGN_BOTTOM = 'Bottom'
const ALIGN_BOTTOM_INDEX = 0

const ALIGN_VERTICAL_CENTER = 'Vertical Center'
const ALIGN_VERTICAL_CENTER_INDEX = 0

const ALIGN_HORIZONTAL_CENTER = 'Horizontal Center'
const ALIGN_HORIZONTAL_CENTER_INDEX = 0

func _ready():
	# Add all the Possible Alignments

	# Add the Horizontal Alignments
	add_item(ALIGN_LEFT, ALIGN_LEFT_INDEX)
	add_item(ALIGN_RIGHT, ALIGN_RIGHT_INDEX)
	add_item(ALIGN_HORIZONTAL_CENTER, ALIGN_HORIZONTAL_CENTER_INDEX)

	# Add the Vertical Alignments
	add_separator()
	add_item(ALIGN_TOP, ALIGN_TOP_INDEX)
	add_item(ALIGN_BOTTOM, ALIGN_BOTTOM_INDEX)
	add_item(ALIGN_VERTICAL_CENTER, ALIGN_VERTICAL_CENTER_INDEX)

	index_pressed.connect(indexPressed)

func indexPressed(index: int):
	match get_item_text(index):
		ALIGN_BOTTOM: EditorGlobal.align_selection_bottom()
		ALIGN_TOP: EditorGlobal.align_selection_top()
		ALIGN_LEFT: EditorGlobal.align_selection_left()
		ALIGN_RIGHT: EditorGlobal.align_selection_right()
		ALIGN_VERTICAL_CENTER: EditorGlobal.align_selection_vertical_center()
		ALIGN_HORIZONTAL_CENTER: EditorGlobal.align_selection_horizontal_center()



