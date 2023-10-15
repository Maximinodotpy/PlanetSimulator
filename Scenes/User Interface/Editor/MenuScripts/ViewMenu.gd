extends PopupMenu

const GO_TO_ORIGIN = 'Go to Origin'
const GO_TO_ORIGIN_INDEX = 0
var GO_TO_ORIGIN_SHORTCUT = EditorGlobal.createShortcut(KEY_PERIOD)

const GO_SELECTION_CENTER = 'Go to Selection Center'
const GO_SELECTION_CENTER_INDEX = 1
var GO_SELECTION_CENTER_SHORTCUT = EditorGlobal.createShortcut(KEY_PERIOD, true)

const FOCUS_CURRENT_PLANET = 'Focus Current Planet'
const FOCUS_CURRENT_PLANET_INDEX = 2
var FOCUS_CURRENT_PLANET_SHORTCUT = EditorGlobal.createShortcut(KEY_F, true)

const BREAK_FOCUS = 'Break Focus'
const BREAK_FOCUS_INDEX = 3
var BREAK_FOCUS_SHORTCUT = EditorGlobal.createShortcut(KEY_F, true, true)

const TOGGLE_SIDE_PANEL = 'Toggle Side Panel'
const TOGGLE_SIDE_PANEL_INDEX = 5
var TOGGLE_SIDE_PANEL_SHORTCUT = EditorGlobal.createShortcut(KEY_B, true)

const TOGGLE_BOTTOM_PANEL = 'Toggle Bottom Panel'
const TOGGLE_BOTTOM_PANEL_INDEX = 6
var TOGGLE_BOTTOM_PANEL_SHORTCUT = EditorGlobal.createShortcut(KEY_J, true)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_item(GO_TO_ORIGIN, GO_TO_ORIGIN_INDEX)
	set_item_shortcut(GO_TO_ORIGIN_INDEX, GO_TO_ORIGIN_SHORTCUT)

	add_item(GO_SELECTION_CENTER, GO_SELECTION_CENTER_INDEX)
	set_item_shortcut(GO_SELECTION_CENTER_INDEX, GO_SELECTION_CENTER_SHORTCUT)

	add_item(FOCUS_CURRENT_PLANET, FOCUS_CURRENT_PLANET_INDEX)
	set_item_shortcut(FOCUS_CURRENT_PLANET_INDEX, FOCUS_CURRENT_PLANET_SHORTCUT)

	add_item(BREAK_FOCUS, BREAK_FOCUS_INDEX)
	set_item_shortcut(BREAK_FOCUS_INDEX, BREAK_FOCUS_SHORTCUT)

	add_separator('User Interface', 4)

	add_item(TOGGLE_SIDE_PANEL, TOGGLE_SIDE_PANEL_INDEX)
	set_item_shortcut(TOGGLE_SIDE_PANEL_INDEX, TOGGLE_SIDE_PANEL_SHORTCUT)

	add_item(TOGGLE_BOTTOM_PANEL, TOGGLE_BOTTOM_PANEL_INDEX)
	set_item_shortcut(TOGGLE_BOTTOM_PANEL_INDEX, TOGGLE_BOTTOM_PANEL_SHORTCUT)

	index_pressed.connect(indexPressed)
	EditorGlobal.anything_changed.connect(react)
	react()

func indexPressed(index: int):
	match get_item_text(index):
		GO_TO_ORIGIN:
			EditorGlobal.unfocus()
			EditorGlobal.get_space_viewport().get_camera_2d().position = Vector2(0, 0)

		GO_SELECTION_CENTER:
			EditorGlobal.unfocus()
			var selectionCenter = EditorGlobal.get_selection_bounding_rect().position + EditorGlobal.get_selection_bounding_rect().size / 2
			EditorGlobal.get_space_viewport().get_camera_2d().position = selectionCenter

		FOCUS_CURRENT_PLANET:
			EditorGlobal.focusObject(EditorGlobal.get_selection()[0])

		BREAK_FOCUS:
			EditorGlobal.unfocus()

		TOGGLE_SIDE_PANEL:
			EditorGlobal.toggle_side_panel.emit()

		TOGGLE_BOTTOM_PANEL:
			EditorGlobal.toggle_status_bar.emit()


func react():
	# Disable Selection Center if nothing is selected
	set_item_disabled(GO_SELECTION_CENTER_INDEX, EditorGlobal.is_empty_selection())

	set_item_disabled(FOCUS_CURRENT_PLANET_INDEX, not EditorGlobal.is_single_selection())

	set_item_disabled(BREAK_FOCUS_INDEX, EditorGlobal.getFocusedObject() == null)
