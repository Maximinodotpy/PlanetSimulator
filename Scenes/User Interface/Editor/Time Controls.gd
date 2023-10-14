extends HBoxContainer

func _process(delta):
	if get_tree().paused:
		$pause_button.text = 'Continue'
	else:
		$pause_button.text = 'Pause'

func pause():
	get_tree().paused = !get_tree().paused

func slower():
	EditorGlobal.set_simulation_speed(EditorGlobal.simulationSpeed - 1)

func faster():
	EditorGlobal.set_simulation_speed(EditorGlobal.simulationSpeed + 1)

func slowest():
	EditorGlobal.simulation_slowest()

func fastest():
	EditorGlobal.simulation_fastest()
