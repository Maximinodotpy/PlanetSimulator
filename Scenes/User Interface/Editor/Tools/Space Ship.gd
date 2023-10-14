extends "res://Scenes/User Interface/Editor/Tools/Tool Template.gd"

var spaceShipScene = preload("res://Scenes/Space Ship/Space Ship.tscn")
var spaceShipSceneInstance: Node2D

func _init():
	tool_name = 'Space Ship'
	tool_icon = preload("res://Theme/Icons/rocket.svg")

func selected():
	EditorGlobal.clear_selection()

	spaceShipSceneInstance = spaceShipScene.instantiate()
	spaceShipSceneInstance.set_position(viewport.get_camera_2d().position)

	print(spaceShipSceneInstance)

	EditorGlobal.get_space().add_child(spaceShipSceneInstance)

	print(spaceShipSceneInstance.is_inside_tree())

	EditorGlobal.focusObject(spaceShipSceneInstance)

func unselected():
	if spaceShipSceneInstance:
		spaceShipSceneInstance.queue_free()

	EditorGlobal.unfocus()
