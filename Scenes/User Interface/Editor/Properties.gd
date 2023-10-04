extends MarginContainer

@onready var container = $v

# Called when the node enters the scene tree for the first time.
func _ready():
	EditorGlobal.selection_changed.connect(renderUI)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not get_tree().paused:
		renderUI()

func renderUI():
#	print('Rendering Property UI')
	for child in container.get_children():
		child.queue_free()

	var selection = EditorGlobal.get_selection()

	var topLabel = Label.new()
	container.add_child(topLabel)

	if selection.size() == 0:
		topLabel.text = 'No Objects Selected'
	elif selection.size() == 1:
		topLabel.text = selection[0].name

		if get_tree().paused:
			pass
		else:
			uiSingleOngoing()

	else:
		topLabel.text = 'Multiple Objects Selected'

func createInfoRow(label_text: String, data: String):
	var hbox = HBoxContainer.new()
	var label = Label.new()
	label.text = label_text
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	var dataLabel = Label.new()
	dataLabel.text = data
	hbox.add_child(label)
	hbox.add_child(dataLabel)
	return hbox

func uiSingleOngoing():
	var object = EditorGlobal.get_selection()[0]

	# Show Velocity
	container.add_child(createInfoRow(
		'Velocity',
		'%s/%s' % [
			round(object.motion.x),
			round(object.motion.y)
		]
	))

	container.add_child(createInfoRow(
		'Position',
		'%s/%s' % [
			round(object.position.x),
			round(object.position.y)
		]
	))

	container.add_child(createInfoRow(
		'Weight',
		str(object.weight)
	))

	container.add_child(createInfoRow(
		'Affects Other',
		str(object.affectsOthers)
	))

	container.add_child(createInfoRow(
		'Is Affected By Others',
		str(object.isAffectedByOthers)
	))

	container.add_child(createInfoRow(
		'PAUSE THE SIMULATION TO EDIT PROPERTIES',
		''
	))
