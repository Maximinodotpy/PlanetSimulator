extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in get_children():
		i.queue_free()

	addStatus('Selected Planets: %s/%s' % [Selection.get_selection().size(), EditorGlobal.get_all_objects().size()])
	addStatus('FPS: %s' % Performance.get_monitor(Performance.TIME_FPS))


func addStatus(text):
	var label = Label.new()
	label.text = text
	add_child(label)
