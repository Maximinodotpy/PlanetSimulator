extends HBoxContainer

var currentTool = 0
var isDragging = false
var dragStart: Vector2
var isDraggingSelection = false

var tools = [
	preload("res://Scenes/User Interface/Editor/Tools/Move.gd").new(),
	preload("res://Scenes/User Interface/Editor/Tools/Select.gd").new(),
	preload("res://Scenes/User Interface/Editor/Tools/Create.gd").new(),
	preload("res://Scenes/User Interface/Editor/Tools/Space Ship.gd").new()
]

func _ready():
	# Create Tools
	var buttonGroup = ButtonGroup.new()

	buttonGroup.connect("pressed", toolSwitched)

	var i = 0
	for tool in tools:
		print('Init: %s' % [tool.tool_name])
		var button = Button.new()
		button.toggle_mode = true
		button.button_group = buttonGroup
		button.text = tool.tool_name
		button.tooltip_text = tool.tool_name
		button.focus_mode = Control.FOCUS_NONE

		button.add_theme_constant_override('h_separation', 10)

		button.icon = tool.tool_icon

		if tool.shortcut_key:
			var shortcut = Shortcut.new()
			var key = InputEventKey.new()
			key.set_keycode(tool.shortcut_key)
			shortcut.events = [ key ]

			button.shortcut = shortcut

		tool.viewport = EditorGlobal.get_space_viewport()

		button.set_meta('id', i)

		add_child(button)

		i += 1

	tools[currentTool].selected()


func toolSwitched(button: Button = Button.new()):
		tools[currentTool].unselected()

		print('Switching Tool from "%s" to "%s"' % [
			tools[currentTool].tool_name,
			tools[button.get_meta('id', 0)].tool_name
		])

		currentTool = button.get_meta('id', 0)
		tools[currentTool].selected()


func sub_viewport_container_gui_input(event):
	var mousePosition = EditorGlobal.get_space().get_global_mouse_position()
	var currentToolScript = tools[currentTool]

	if event is InputEventMouseMotion:
		if isDragging:
			if isDraggingSelection:
				currentToolScript.selectionDragging(dragStart, mousePosition)
			else:
				currentToolScript.dragging(dragStart, mousePosition)

		currentToolScript.mouse_moved()

	elif event is InputEventMouseButton:

		if get_viewport().gui_get_focus_owner():
			get_viewport().gui_get_focus_owner().release_focus()

		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				isDragging = true
				isDraggingSelection = EditorGlobal.get_selection_bounding_rect().has_point(mousePosition)

				dragStart = mousePosition
				if isDraggingSelection:
					currentToolScript.selectionDragStart(dragStart)
				else:
					currentToolScript.dragStart(dragStart)

			else:
				isDragging = false
				currentToolScript.clicked()

				if isDraggingSelection:
					currentToolScript.selectionDragEnd(dragStart, mousePosition)
				else:
					currentToolScript.dragEnd(dragStart, mousePosition)

				isDraggingSelection = false
