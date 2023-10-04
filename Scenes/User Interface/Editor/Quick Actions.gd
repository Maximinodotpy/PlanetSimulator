extends MarginContainer

var quickActionsAlways = [

]

var quickActionsNothing = [
	[ 'Select All', EditorGlobal.select_all ],
]

var quickActionsSingle = [
	[ 'Delete Selected', EditorGlobal.delete_selected ],
	[ 'Unselect', EditorGlobal.clear_selection ],
	[ 'Stop', EditorGlobal.stop_selected ],
]

var quickActionsMultiple = [
	[ 'Delete Selected', EditorGlobal.delete_selected ],
	[ 'Align Left', EditorGlobal.align_selection_left ],
	[ 'Align Right', EditorGlobal.align_selection_right ],
	[ 'Align Top', EditorGlobal.align_selection_top ],
	[ 'Align Bottom', EditorGlobal.align_selection_bottom ],
	[ 'Center Vertically', EditorGlobal.center_selection_vertically ],
	[ 'Center Horizontally', EditorGlobal.center_selection_horizontaly ],
	[ 'Unselect All', EditorGlobal.clear_selection ],
	[ 'Stop All', EditorGlobal.stop_selected ],
]

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready():
	EditorGlobal.selection_changed.connect(renderActions)
	renderActions()

func renderActions():
	var actions = quickActionsAlways.duplicate(true)

	if EditorGlobal.get_selection().size() == 1:
		actions.append_array(quickActionsSingle.duplicate(true))
	elif EditorGlobal.get_selection().size() > 1:
		actions.append_array(quickActionsMultiple.duplicate(true))
	else:
		actions.append_array(quickActionsNothing.duplicate(true))

	for child in $"h-flow".get_children():
		child.queue_free()

	for action in actions:
		var button = Button.new()
		button.text = action[0]
		button.connect('pressed', action[1])
		button.focus_mode = Control.FOCUS_NONE
		$"h-flow".add_child(button)
