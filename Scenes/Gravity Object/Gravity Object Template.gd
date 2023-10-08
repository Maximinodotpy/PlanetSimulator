extends Node2D

@export var motion = Vector2(0, 0)
@export var weight = 1
@export var affectsOthers = true
@export var isAffectedByOthers = true

func _process(delta):
	call_deferred("apply_motion", delta)

	frameReaction()

	if not isAffectedByOthers:
		return

	for simulationStep in range(EditorGlobal.simulationSpeed):
		for object in EditorGlobal.get_all_objects():
			if object == self or not object.affectsOthers or object.is_queued_for_deletion():
				continue

			var distance = position.distance_to(object.position)
			var direction = (self.position - object.position).normalized()
			var myMass = self.weight
			var theirMass = object.weight

			const MASS_MULTIPLIER = 1_000_000

			# Find out it if the Distance is less then their radi only do this in the first
			if simulationStep == 0:
				if distance < weight * 5 + object.weight * 5:
					if weight > object.weight:
						weight += object.weight
						EditorGlobal.remove_from_selection(object)
						object.queue_free()
					else:
						object.weight += weight
						EditorGlobal.remove_from_selection(self)
						queue_free()

			# Calculate gravitational force
			var force = grav_force(myMass * MASS_MULTIPLIER, theirMass * MASS_MULTIPLIER, distance)

			var acceleration = force / myMass

			motion -= direction * acceleration * delta

func frameReaction():
	pass

# Calculate the gravitational force between 2 objects
func grav_force(m1: float, m2: float, r: float) -> float:
	var G = 6.675e-11

	var F = G * m1 * m2 / r**2
	return F

func apply_motion(delta):
	for simulationStep in range(EditorGlobal.simulationSpeed):
		set_position(position + motion * delta)
