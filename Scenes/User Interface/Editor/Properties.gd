extends MarginContainer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if EditorGlobal.get_selection().size() == 0:
		$"v/Property Editor Single".hide()
		$"v/Property Editor Multiple".hide()
	elif EditorGlobal.get_selection().size() == 1:
		$"v/Property Editor Single".show()
		$"v/Property Editor Multiple".hide()
	elif EditorGlobal.get_selection().size() > 1:
		$"v/Property Editor Multiple".show()
		$"v/Property Editor Single".hide()
