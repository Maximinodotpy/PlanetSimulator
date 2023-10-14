extends Control

#@onready var selectedRect = $v/main/SpaceContainer/SubViewportContainer/space_viewport/SelectedRect

func _ready():
	if EditorSaves.currentSaveName != '':
		EditorSaves.load_file()

	EditorGlobal.reset_simulation_speed()
	EditorGlobal.pause_simulation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_DELETE):
		EditorGlobal.delete_selected()

	call_deferred('focusCameraToObject')

func focusCameraToObject():
	if EditorGlobal.getFocusedObject():
		print('Focusing')

		var cameraPos = EditorGlobal.get_space_viewport().get_camera_2d().position
		var focusedObjectMotion = EditorGlobal.getFocusedObject().motion
		var focusObjectPos = EditorGlobal.getFocusedObject().position
		var offset = cameraPos - focusObjectPos

		if not get_tree().paused:
			pass
#			EditorGlobal.get_space_viewport().get_camera_2d().position += focusedObjectMotion * (EditorGlobal.get_simulation_speed() ** 2)
