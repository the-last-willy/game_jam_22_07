extends Spatial
class_name Passenger

var speed: float
var strength: float
var fear: float
var anger: float
var protector: float
var weight: float
var luggage: Luggage

func set_speed(_speed):
	speed = _speed

func set_strength(_strength):
	strength = _strength
	$Label.text = str(strength)

func set_fear(_fear):
	fear = _fear
	
func set_anger(_anger):
	anger = _anger
	
func set_protector(_protector):
	protector = _protector

func set_weight(_weight):
	weight = _weight

func set_luggage(_luggage):
	luggage = _luggage

func get_speed():
	return speed

func get_strength():
	return strength
	
func get_fear():
	return fear
	
func get_anger():
	return anger
	
func get_protector():
	return protector
	
func get_weight():
	return weight

func _process(_delta):
	$Label.rect_position = get_viewport().get_camera().unproject_position(global_transform.origin + Vector3.UP * 1.5)

func _on_Area_body_entered(body):
	if body as Player:
		body.add_near_passenger(self)


func _on_Area_body_exited(body):
	if body as Player:
		body.remove_near_passenger(self)
