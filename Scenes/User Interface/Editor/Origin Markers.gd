extends Node2D

@onready var xLine = $X
@onready var yLine = $Y

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var visibleRectSize = EditorGlobal.get_space_viewport().get_visible_rect().size
	var viewportTransform = get_viewport_transform()

	var top = -viewportTransform.origin.y / viewportTransform.y.y
	var left = -viewportTransform.origin.x / viewportTransform.x.x

	xLine.points[0].y = top
	xLine.points[1].y = top + get_viewport_rect().size.y / viewportTransform.y.y

	yLine.points[0].x = left
	yLine.points[1].x = left + get_viewport_rect().size.x / viewportTransform.x.x
