extends Spatial

var speed: float
var strength: float
var fear: float
var anger: float
var protector: float

func set_speed(_speed):
	speed = _speed

func set_strength(_strength):
	strength = _strength
	
func set_fear(_fear):
	fear = _fear
	
func set_anger(_anger):
	anger = _anger
	
func set_protector(_protector):
	protector = _protector


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
