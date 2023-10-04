extends VBoxContainer

func _ready():
	renderObjects()

func _process(delta):
	for child in get_children():
		child.queue_free()

	renderObjects()

func renderObjects():
	for object in get_tree().get_nodes_in_group('gravity_object'):

		var hbox = HBoxContainer.new()

		var label = Label.new()

		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		var checkbox = CheckBox.new()

		checkbox.button_pressed = object in EditorGlobal.get_selection()

		label.text = '%s (D: %s)' % [
			object.name,
			object.motion,
		]

		hbox.add_child(label)
		hbox.add_child(checkbox)

		self.add_child(hbox)
