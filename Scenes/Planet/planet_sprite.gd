extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	EditorGlobal.anything_changed.connect(queue_redraw)
	Selection.selection_changed.connect(queue_redraw)

func _process(delta):
	queue_redraw()

func _draw():
	var color = Color.WHITE

	if get_parent() in Selection.get_selection():
		color  = Color.AQUA

	draw_circle(Vector2(0, 0), 500 * get_parent().weight, color)
