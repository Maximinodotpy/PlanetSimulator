extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	EditorGlobal.selection_changed.connect(queue_redraw)

func _draw():
	var color = Color.WHITE

	if get_parent() in EditorGlobal.get_selection():
		color  = Color.AQUA

	draw_circle(Vector2(0, 0), 500 * get_parent().weight, color)
