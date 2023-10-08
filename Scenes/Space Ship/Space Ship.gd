extends "res://Scenes/Gravity Object/Gravity Object Template.gd"

func frameReaction():
	print('Hallo')

	if Input.is_key_pressed(KEY_LEFT):
		rotation_degrees -= 5
	if Input.is_key_pressed(KEY_RIGHT):
		rotation_degrees += 5

	if Input.is_key_pressed(KEY_UP):
		var accel = (float(-5) / float(EditorGlobal.get_simulation_speed()))

		motion += Vector2(0, accel).rotated(rotation)
