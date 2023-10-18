extends CharacterBody2D

@export var motion = Vector2(0, 0)
@export var weight = 1
@export var affectsOthers = true
@export var isAffectedByOthers = true

@onready var collision_cast = $collision_cast
@onready var collision_shape_2d = $CollisionShape2D

func _process(delta):
	call_deferred("apply_motion", delta)

	frameReaction()

	if not isAffectedByOthers:
		return

	for object in EditorGlobal.get_all_objects():
		if object == self or not object.affectsOthers or object.is_queued_for_deletion():
			continue

		var distance = position.distance_to(object.position)
		var direction = (self.position - object.position).normalized()
		var myMass = self.weight
		var theirMass = object.weight

		const MASS_MULTIPLIER = 1_000_000

		# Calculate gravitational force
		var force = grav_force(myMass * MASS_MULTIPLIER, theirMass * MASS_MULTIPLIER, distance)

		var acceleration = force / myMass

		motion -= (direction * acceleration * delta) * EditorGlobal.simulationSpeed

	collision_cast.target_position = motion * 5
	collision_shape_2d.shape.radius = weight * 5

	if collision_cast.is_colliding():
		var object = collision_cast.get_collider()

		if weight > object.weight:
			weight += object.weight
			EditorGlobal.remove_from_selection(object)
			object.queue_free()

		else:
			object.weight += weight
			EditorGlobal.remove_from_selection(self)
			queue_free()

func frameReaction():
	pass

# Calculate the gravitational force between 2 objects
func grav_force(m1: float, m2: float, r: float) -> float:
	var G = 6.675e-11
	var F = G * m1 * m2 / r**2

	return F

func apply_motion(delta):
	set_position(position + (motion * delta) * EditorGlobal.simulationSpeed)
