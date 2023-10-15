extends Control

func _ready():
	if EditorSaves.currentSaveName != '':
		EditorSaves.load_file()

	EditorGlobal.reset_simulation_speed()
	EditorGlobal.pause_simulation()

func _process(delta):
	call_deferred('focusCameraToObject')

func focusCameraToObject():
	if is_instance_valid(EditorGlobal.getFocusedObject()):
		var focusObjectPos = EditorGlobal.getFocusedObject().position
		EditorGlobal.get_space_viewport().get_camera_2d().position = focusObjectPos
