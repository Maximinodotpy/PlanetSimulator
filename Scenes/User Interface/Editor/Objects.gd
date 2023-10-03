extends VBoxContainer

func _ready():
	renderObjects()

func _process(delta):
	for child in get_children():
		child.queue_free()

	renderObjects()

func renderObjects():
	for object in get_tree().get_nodes_in_group('gravity_object'):
		var label = Label.new()

		label.text = '%s (D: %s)' % [
			object.name,
			object.motion,
		]

		self.add_child(label)
