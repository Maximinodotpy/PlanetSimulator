extends "res://Scenes/User Interface/Editor/Tools/Tool Template.gd"

func _init():
	tool_name = 'Pan'
	shortcut_key = KEY_P

func selected():
	if viewport.get_camera_2d().has_method('continuePanzoom'):
		viewport.get_camera_2d().continuePanzoom()

func unselected():
	viewport.get_camera_2d().pausePanzoom()
