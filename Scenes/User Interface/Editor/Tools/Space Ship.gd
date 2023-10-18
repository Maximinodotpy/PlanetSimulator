extends "res://Scenes/User Interface/Editor/Tools/Tool Template.gd"

var spaceShipScene = preload("res://Scenes/Space Ship/Space Ship.tscn")
var spaceShipSceneInstance: Node2D

func _init():
	tool_name = 'Space Ship'
	tool_icon = preload("res://Theme/Icons/rocket.svg")

func selected():
	EditorGlobal.anything_changed.emit()
	Selection.clear_selection()

	spaceShipSceneInstance = spaceShipScene.instantiate()
	spaceShipSceneInstance.set_position(viewport.get_camera_2d().position)

	EditorGlobal.get_space().add_child(spaceShipSceneInstance)

	EditorGlobal.focusObject(spaceShipSceneInstance)

func unselected():
	if is_instance_valid(spaceShipSceneInstance):
		spaceShipSceneInstance.queue_free()

	EditorGlobal.unfocus()

	EditorGlobal.anything_changed.emit()
