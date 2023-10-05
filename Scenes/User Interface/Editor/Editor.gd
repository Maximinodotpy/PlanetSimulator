extends Control


@onready var status_container = $v/bottom/h/status

@onready var spaceViewport = EditorGlobal.get_space_viewport()
@onready var space = EditorGlobal.get_space()

@onready var selectedRect = $v/main/SpaceContainer/SubViewportContainer/space_viewport/SelectedRect

var tools = [
	preload("res://Scenes/User Interface/Editor/Tools/Move.gd").new(),
	preload("res://Scenes/User Interface/Editor/Tools/Select.gd").new(),
	preload("res://Scenes/User Interface/Editor/Tools/Create.gd").new()
]

var currentTool = 0
var isDragging = false
var dragStart: Vector2
var isDraggingSelection = false

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
		button.focus_mode = Control.FOCUS_NONE

		if tool.shortcut_key:
			var shortcut = Shortcut.new()
			var key = InputEventKey.new()
			key.set_keycode(tool.shortcut_key)
			shortcut.events = [ key ]

			button.shortcut = shortcut

		tool.viewport = spaceViewport

		button.set_meta('id', i)

		$v/top/HBoxContainer/tools/tools.add_child(button)

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	EditorGlobal.simulationSpeed = clampf(EditorGlobal.simulationSpeed, 0.1, 10)

	var selection_rect = EditorGlobal.get_selection_bounding_rect()

	selectedRect.position = selection_rect.position
	selectedRect.size = selection_rect.size

	if Input.is_key_pressed(KEY_DELETE):
		EditorGlobal.delete_selected()

	for i in status_container.get_children():
		i.queue_free()

	if spaceViewport.get_camera_2d():
		var camPos = spaceViewport.get_camera_2d().position
		var camZoom = spaceViewport.get_camera_2d().zoom.x
		addStatus('Camera Position: %s/%s' % [round(camPos.x), round(camPos.y)])

		addStatus('Camera Zoom: %s%%' % [ round(camZoom * 100) ])

	addStatus('Planets: %s' % get_tree().get_nodes_in_group('gravity_object').size())

	addStatus('Selected Planets: %s' % EditorGlobal.get_selection().size())

	addStatus('FPS: %s' % Performance.get_monitor(Performance.TIME_FPS))

	addStatus('Simulation Speed: %s%%' % [ EditorGlobal.simulationSpeed * 100 ])




func addStatus(text):
	var label = Label.new()
	label.text = text
	status_container.add_child(label)


func _on_pause_button_pressed():
	get_tree().paused = !get_tree().paused

	if get_tree().paused:
		$v/bottom/h/pause_button.text = 'Continue'
	else:
		$v/bottom/h/pause_button.text = 'Pause'


func _on_slower_button_pressed():
	EditorGlobal.simulationSpeed -= 0.1

func _on_faster_button_pressed():
	EditorGlobal.simulationSpeed += 0.1


func _on_sub_viewport_container_gui_input(event):
	var mousePosition = space.get_global_mouse_position()
	var currentToolScript = tools[currentTool]

	if event is InputEventMouseMotion:
		if isDragging:
			if isDraggingSelection:
				currentToolScript.selectionDragging(dragStart, mousePosition)
			else:
				currentToolScript.dragging(dragStart, mousePosition)

		currentToolScript.mouse_moved()

	elif event is InputEventMouseButton:

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
