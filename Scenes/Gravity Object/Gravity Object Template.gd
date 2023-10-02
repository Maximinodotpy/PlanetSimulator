extends Node2D

@export var motion = Vector2(0, 0)
@export var weight = 1

func _process(delta):
	call_deferred("apply_motion", delta)

	for object in get_tree().get_nodes_in_group('gravity_object'):
		if object == self:
			continue

		var distanceSquared = position.distance_squared_to(object.position)
		var myMass = self.weight
		var theirMass = object.weight

		print(grav_force(myMass, theirMass, distanceSquared))

		motion += position.direction_to(object.position) * object.weight

# Calculate the gravitational force between 2 objects
func grav_force(m1, m2, r):
	# Newtons constant
	var G = 6.674*(10**-11)
	var formula = G * (m1 * m2 / r)
	return formula

func apply_motion(delta):
	print('Delta ' + str(delta))
	position += motion * delta * SpaceGlobal.simulationSpeed
