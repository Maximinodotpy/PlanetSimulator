extends VBoxContainer

func _ready():
	renderObjects()

	EditorGlobal.anything_changed.connect(renderObjects, CONNECT_DEFERRED)

	Objects.on_object_removed.connect(renderObjects, CONNECT_DEFERRED)

func renderObjects():
	print('Rendering Objects Panel')

	for child in get_children():
		child.queue_free()

	for object in get_tree().get_nodes_in_group('gravity_object'):

		print(is_instance_valid(object))

		var hbox = HBoxContainer.new()

		var lineEdit = LineEdit.new()
		var lcb = func(arg = ''):
			lineEditCallback(object, lineEdit)
		lineEdit.text_submitted.connect(lcb)
		lineEdit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		lineEdit.flat = true

		var checkbox = CheckBox.new()
		checkbox.focus_mode = Control.FOCUS_NONE
		var ccb = func():
			checkBoxCallback(object, checkbox)
		checkbox.pressed.connect(ccb)

		checkbox.button_pressed = object in Selection.get_selection()

		lineEdit.text = '%s' % [ object.name, ]

		hbox.add_child(lineEdit)
		hbox.add_child(checkbox)

		self.add_child(hbox)

func lineEditCallback(object: Node2D, lineedit: LineEdit):
	EditorGlobal.rename_object(object, lineedit.text)

func checkBoxCallback(object: Node2D, checkbox: CheckBox):
	if checkbox.button_pressed:
		Selection.add_to_selection(object)
	else:
		Selection.remove_from_selection(object)

