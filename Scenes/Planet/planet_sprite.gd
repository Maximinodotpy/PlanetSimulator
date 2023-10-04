extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	scale = Vector2(get_parent().weight, get_parent().weight)

func _draw():
	draw_circle(Vector2(0, 0), 500 * get_parent().weight, Color.WHITE)
