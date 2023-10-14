extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in get_children():
		i.queue_free()

#	if EditorGlobal.get_space_viewport().get_camera_2d():
#		var camPos = EditorGlobal.get_space_viewport().get_camera_2d().position
#		var camZoom = EditorGlobal.get_space_viewport().get_camera_2d().zoom.x
#		addStatus('Camera Position: %s/%s' % [round(camPos.x), round(camPos.y)])
#		addStatus('Camera Zoom: %s%%' % [ round(camZoom * 100) ])

	addStatus('Planets: %s' % EditorGlobal.get_all_objects().size())
	addStatus('Selected Planets: %s' % EditorGlobal.get_selection().size())
	addStatus('FPS: %s' % Performance.get_monitor(Performance.TIME_FPS))

#	addStatus('Simulation Speed: %s Step(s) Per Frame' % [ EditorGlobal.simulationSpeed ])


func addStatus(text):
	var label = Label.new()
	label.text = text
	add_child(label)
