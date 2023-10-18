extends "res://Scenes/User Interface/Editor/Tools/Tool Template.gd"

func _init():
	tool_name = 'Create'
	shortcut_key = KEY_C
	tool_icon = preload("res://Theme/Icons/plus-circle.svg")

func dragEnd(starPos, endPos):
	var planet: Planet = Objects.add_object()

	planet.position = endPos
	planet.motion = (starPos - endPos) * 5

func unselected():
	pass
