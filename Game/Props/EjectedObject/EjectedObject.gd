extends KinematicBody

var velocity: Vector3 = Vector3(0, 0, 0)

func _process(delta):
	translate(velocity * delta)
	$Pivot.rotation.y += deg2rad(3 * 360) * delta
