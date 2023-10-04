extends "res://Scenes/User Interface/Editor/Tools/Tool Template.gd"

var planet = preload("res://Scenes/Planet/Planet.tscn")

func _init():
	tool_name = 'Create'
	shortcut_key = KEY_C

func selected():
	pass

func dragStart(startPos):
	pass

func dragging(startPos, currentPos):
	pass

func dragEnd(starPos, endPos):
	print('Clicked (Drag End)')

	var planeteI: Node2D = planet.instantiate()

	planeteI.position = endPos

	planeteI.motion = (starPos - endPos) * 5

	EditorGlobal.get_space().add_child(planeteI)

func unselected():
	pass
