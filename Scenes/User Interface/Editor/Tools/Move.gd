extends "res://Scenes/User Interface/Editor/Tools/Tool Template.gd"

func _init():
	tool_name = 'Pan'
	shortcut_key = KEY_P

func selected():
	viewport.get_camera_2d().continuePanzoom()

func unselected():
	viewport.get_camera_2d().pausePanzoom()
