extends Line2D

const tracerLen = 100
const tracerInterval = 10

var counter = 0

func _ready():
	EditorGlobal.selection_changed.connect(changeColor)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	width = get_parent().weight * 2

	if points.size() >= 1:
		points[0] = get_parent().position

	if counter >= (tracerInterval * (EditorGlobal.MAX_SIMULATION_SPEED - EditorGlobal.get_simulation_speed())):
		counter = 0

		add_point(get_parent().position, 0)
		var tempPoints = points
		tempPoints.resize(min(tracerLen, tempPoints.size()))
		points = tempPoints

	counter += 1

func changeColor():
	if get_parent() in EditorGlobal.get_selection():
		default_color = Color(0.6235294342041, 0.40000000596046, 0.76078432798386)
	else:
		default_color = Color(0, 0.4, 0.76)
