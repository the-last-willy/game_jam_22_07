extends Spatial
class_name Passenger

var speed: float
var strength: float
var fear: float
var anger: float
var protector: float
var weight: float
var luggage: Luggage

var angryness: float = 0.5
var terrless: float = 0.5

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

func _process(delta):
	$Label.rect_position = get_viewport().get_camera().unproject_position(global_transform.origin + Vector3.UP * 1.5)
	$Label.text = str(strength)
	var randVal = randi() % 100 * anger
	var randVal2 = randi() % 100 * fear
	if(randVal < 75 ) :
		update_angryness(delta)
	if(randVal2 < 75) :
		update_terrless(delta)

func update_angryness(delta):
	var randVal = randf()
	if(angryness >0) :
		angryness -= (randVal / anger) * delta * 0.01
	
func update_terrless(delta):
	var randVal = randf()
	terrless -= (randVal / fear) * delta * 0.01
	
func ejected_passenger():
	var randVala = randi() % 100 * anger
	var randValf = randi() % 100 * fear
	if(randVala > 50 ) :
		var randVal = randf()
		angryness += (randVal * fear) * 0.1
	if(randValf > 50 ) :
		var randVal = randf()
		terrless += (randVal * fear) * 0.1

func ejected_luggage():
	luggage.queue_free()
	luggage = null
	var randVala = randi() % 100 * anger
	var randValf = randi() % 100 * fear
	if(randVala > 50 ) :
		var randVal = randf()
		angryness += (randVal * fear) * 0.05
	if(randValf > 50 ) :
		var randVal = randf()
		terrless += (randVal * fear) * 0.05

func _on_Area_body_entered(body):
	if body as Player:
		body.add_near_passenger(self)

func _on_Area_body_exited(body):
	if body as Player:
		body.remove_near_passenger(self)
