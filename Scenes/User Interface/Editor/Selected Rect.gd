extends Panel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var selection_rect = Selection.get_selection_bounding_rect()

	position = selection_rect.position
	size = selection_rect.size
