extends MarginContainer

var quickActionsAlways = [

]

var quickActionsNothing = [
	[ 'Select All', Selection.select_all ],
]

var quickActionsSingle = [
	[ 'Delete Selected', Selection.delete_selected ],
	[ 'Unselect', Selection.clear_selection ],
	[ 'Stop', Selection.stop_selected ],
]

var quickActionsMultiple = [
	[ 'Delete Selected', Selection.delete_selected ],
	[ 'Align Left', Selection.align_selection_left ],
	[ 'Align Right', Selection.align_selection_right ],
	[ 'Align Top', Selection.align_selection_top ],
	[ 'Align Bottom', Selection.align_selection_bottom ],
	[ 'Center Vertically', Selection.center_selection_vertically ],
	[ 'Center Horizontally', Selection.center_selection_horizontaly ],
	[ 'Unselect All', Selection.clear_selection ],
	[ 'Stop All', Selection.stop_selected ],
]

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready():
	Selection.selection_changed.connect(renderActions)
	renderActions()

func renderActions():
	var actions = quickActionsAlways.duplicate(true)

	if Selection.get_selection().size() == 1:
		actions.append_array(quickActionsSingle.duplicate(true))
	elif Selection.get_selection().size() > 1:
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
