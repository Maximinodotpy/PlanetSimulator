extends VBoxContainer

@onready var pause_button = $Buttons/pause_button

func _process(delta):
	if get_tree().paused:
		pause_button.text = 'Continue'
	else:
		pause_button.text = 'Pause'

	$"ProgressBar".value = lerpf(
		$"ProgressBar".value,
		EditorGlobal.get_simulation_speed(),
		0.1
	)

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
