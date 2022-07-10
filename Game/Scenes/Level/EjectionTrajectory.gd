extends Path

export var ejection_speed : float = 10

var EjectedObjectScene = load("res://Game/Props/EjectedObject/EjectedObject.tscn")

func _ready():
	pass

func _progress(_delta):
	pass

func eject(entity: Node):
	var ejection = EjectedObjectScene.instance()
	ejection.translation = origin() + 2 * (Vector3(randf(), randf(), randf()) * 2 - Vector3(1,1,1))
	ejection.velocity = direction() * ejection_speed
	if entity.get_parent():
		entity.get_parent().remove_child(entity)
	entity.translation = Vector3(0,0,0)
	ejection.get_node("Pivot").add_child(entity)
	$Objects.add_child(ejection)

func origin() -> Vector3:
	var curve: Curve3D = get_curve()
	return curve.get_point_position(0)

func direction() -> Vector3:
	var curve: Curve3D = get_curve()
	var p0: Vector3 = curve.get_point_position(0)
	var p1: Vector3 = curve.get_point_position(1)
	return (p1 - p0).normalized()
