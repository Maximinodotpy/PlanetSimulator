extends "res://Scenes/Gravity Object/Gravity Object Template.gd"

func _init():
	pass

func frameReaction():
	if Input.is_key_pressed(KEY_LEFT):
		rotation_degrees -= 5
	if Input.is_key_pressed(KEY_RIGHT):
		rotation_degrees += 5

	if Input.is_key_pressed(KEY_UP):
		motion += Vector2(0, -5).rotated(rotation)
