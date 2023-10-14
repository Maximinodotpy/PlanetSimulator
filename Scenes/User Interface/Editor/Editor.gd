extends Control

func _ready():
	if EditorSaves.currentSaveName != '':
		EditorSaves.load_file()

	EditorGlobal.reset_simulation_speed()
	EditorGlobal.pause_simulation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	call_deferred('focusCameraToObject')

func focusCameraToObject():
	if EditorGlobal.getFocusedObject():
		var focusObjectPos = EditorGlobal.getFocusedObject().position

		EditorGlobal.get_space_viewport().get_camera_2d().position = focusObjectPos
