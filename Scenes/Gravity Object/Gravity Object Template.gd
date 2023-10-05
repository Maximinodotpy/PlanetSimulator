extends Node2D

@export var motion = Vector2(0, 0)
@export var weight = 1
@export var affectsOthers = true
@export var isAffectedByOthers = true

func _ready():
	print('Gravity Object Created')
	print(motion)
	print(get_groups())

func _process(delta):
	call_deferred("apply_motion", delta)

	if not isAffectedByOthers:
		return

	for object in get_tree().get_nodes_in_group('gravity_object'):
		if object == self:
			continue

		var distanceSquared = position.distance_squared_to(object.position)
		var myMass = self.weight
		var theirMass = object.weight

		motion += position.direction_to(object.position) * object.weight

# Calculate the gravitational force between 2 objects
func grav_force(m1, m2, r):
	# Newtons constant
	var G = 6.674*(10**-11)
	var formula = G * (m1 * m2 / r)
	return formula

func apply_motion(delta):
	set_position(position + motion * delta * EditorGlobal.simulationSpeed)
