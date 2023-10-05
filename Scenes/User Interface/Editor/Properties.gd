extends MarginContainer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for child in $"v".get_children():
		child.hide()

	$"v/Property Label".show()


	if EditorGlobal.get_selection().size() == 0:
		pass
	elif EditorGlobal.get_selection().size() == 1:
		$"v/Property Editor Single".show()
	elif EditorGlobal.get_selection().size() > 1:
		$"v/Property Editor Multiple".show()
