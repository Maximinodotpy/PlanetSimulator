extends "res://Scenes/User Interface/Editor/Tools/Tool Template.gd"

func _init():
	tool_name = 'Create'
	shortcut_key = KEY_C

func dragEnd(starPos, endPos):
	var planet: Planet = EditorGlobal.add_object(EditorGlobal.OBJECT_TYPES.Planet)

	planet.position = endPos
	planet.motion = (starPos - endPos) * 5

func unselected():
	pass
