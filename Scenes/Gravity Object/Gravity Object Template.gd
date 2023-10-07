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
		if object == self or not object.affectsOthers:
			continue

		var distance = position.distance_to(object.position)
		var direction = (self.position - object.position).normalized()
		var myMass = self.weight
		var theirMass = object.weight

		const MASS_MULTIPLIER = 1_000_000

		# Find out it if the Distance is less then their radi
		if distance < weight * 5 + object.weight * 5:
			if weight > object.weight:
				weight += object.weight
				object.queue_free()
			else:
				object.weight += weight
				queue_free()

		# Calculate gravitational force
		var force = grav_force(myMass * MASS_MULTIPLIER, theirMass * MASS_MULTIPLIER, distance)

		var acceleration = force / myMass

		motion -= direction * acceleration * delta * EditorGlobal.simulationSpeed

	frameReaction()

func frameReaction():
	pass

# Calculate the gravitational force between 2 objects
func grav_force(m1: float, m2: float, r: float) -> float:
	var G = 6.675e-11

	var F = G * m1 * m2 / r**2
	return F

func apply_motion(delta):
	set_position(position + motion * delta * EditorGlobal.simulationSpeed)
