extends PopupMenu

const GO_TO_ORIGIN = 'Go to Origin'
const GO_TO_ORIGIN_INDEX = 0

const GO_SELECTION_CENTER = 'Go to Selection Center'
const GO_SELECTION_CENTER_INDEX = 1

const FOCUS_CURRENT_PLANET = 'Focus Current Planet'
const FOCUS_CURRENT_PLANET_INDEX = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	add_item(GO_TO_ORIGIN, GO_TO_ORIGIN_INDEX)
	add_item(GO_SELECTION_CENTER, GO_SELECTION_CENTER_INDEX)
	add_item(FOCUS_CURRENT_PLANET, FOCUS_CURRENT_PLANET_INDEX)

	index_pressed.connect(indexPressed)
	EditorGlobal.anything_changed.connect(react)
	react()

func indexPressed(index: int):
	match get_item_text(index):
		GO_TO_ORIGIN: EditorGlobal.get_space_viewport().get_camera_2d().position = Vector2(0, 0)
		GO_SELECTION_CENTER:
			var selectionCenter = EditorGlobal.get_selection_bounding_rect().position + EditorGlobal.get_selection_bounding_rect().size / 2
			EditorGlobal.get_space_viewport().get_camera_2d().position = selectionCenter
		FOCUS_CURRENT_PLANET:
			EditorGlobal.focusObject(EditorGlobal.get_selection()[0])


func react():
	# Disable Selection Center if nothing is selected
	set_item_disabled(GO_SELECTION_CENTER_INDEX, EditorGlobal.is_empty_selection())

	set_item_disabled(FOCUS_CURRENT_PLANET_INDEX, not EditorGlobal.is_single_selection())
