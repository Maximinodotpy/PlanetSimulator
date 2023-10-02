extends Control


@onready var status_container = $v/bottom/h/status

@onready var spaceViewport = $v/space/SubViewportContainer/SubViewport

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	SpaceGlobal.simulationSpeed = clampf(SpaceGlobal.simulationSpeed, 0.1, 10)

	for i in status_container.get_children():
		i.queue_free()

	if spaceViewport.get_camera_2d():
		var camPos = spaceViewport.get_camera_2d().position
		var camZoom = spaceViewport.get_camera_2d().zoom.x
		addStatus('Camera Position: %s/%s' % [round(camPos.x), round(camPos.y)])

		addStatus('Camera Zoom: %s%%' % [ round(camZoom * 100) ])

	addStatus('Planets: %s' % get_tree().get_nodes_in_group('gravity_object').size())

	addStatus('FPS: %s' % Performance.get_monitor(Performance.TIME_FPS))

	addStatus('Simulation Speed: %s%%' % [ SpaceGlobal.simulationSpeed * 100 ])


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
	SpaceGlobal.simulationSpeed -= 0.1

func _on_faster_button_pressed():
	SpaceGlobal.simulationSpeed += 0.1
