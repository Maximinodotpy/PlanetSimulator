extends "res://Scenes/User Interface/Editor/Tools/Tool Template.gd"

var spaceShipScene = preload("res://Scenes/Space Ship/Space Ship.tscn")
var spaceShipSceneInstance: Node2D
var preCam: Camera2D

func _init():
	tool_name = 'Space Ship'

func selected():
	EditorGlobal.clear_selection()

	spaceShipSceneInstance = spaceShipScene.instantiate()

	spaceShipSceneInstance.set_position(viewport.get_camera_2d().position)

	preCam = EditorGlobal.get_space_viewport().get_camera_2d()
	EditorGlobal.get_space_viewport().get_camera_2d().enabled = false

	EditorGlobal.get_space().add_child(spaceShipSceneInstance)

	viewport.get_camera_2d().zoom = preCam.zoom

func unselected():
	spaceShipSceneInstance.queue_free()

	viewport.get_camera_2d().enabled = false
	preCam.enabled = true

	preCam.position = spaceShipSceneInstance.position
	preCam.zoom = viewport.get_camera_2d().zoom
