extends "res://Scenes/Gravity Object/Gravity Object Template.gd"

@onready var speed_label = $"CanvasLayer/MarginContainer/Speed Label"


func _ready():
	affectsOthers = false

func frameReaction():
	speed_label.text = '%s m/s' % [ roundi(motion.length()) ]

	if Input.is_key_pressed(KEY_LEFT):
		rotation_degrees -= 5
	if Input.is_key_pressed(KEY_RIGHT):
		rotation_degrees += 5

	if Input.is_key_pressed(KEY_UP):
		var accel_speed = 5

		if Input.is_key_pressed(KEY_CTRL):
			accel_speed = 2

		var accel = (float(-accel_speed) / float(EditorGlobal.get_simulation_speed()))

		motion += Vector2(0, accel).rotated(rotation)
