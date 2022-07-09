extends Spatial
class_name Passenger

signal ejected(passenger)

var speed: float
var strength: float
var saved_strength: float
var fear: float
var anger: float
var protector: float
var saved_protector: float
var weight: float
var luggage_ejectable : bool = true
var luggage: Luggage
var timer:Timer
var tried : bool = false

var angryness: float = 0.5
var terrless: float = 0.5

func set_speed(_speed):
	speed = _speed

func set_strength(_strength):
	strength = _strength
	saved_strength = strength

func set_fear(_fear):
	fear = _fear
	
func set_anger(_anger):
	anger = _anger
	
func set_protector(_protector):
	protector = _protector
	saved_protector = protector

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
	
func _ready():
	GameManager.register_passenger(self)
	
	timer = Timer.new()
	
	add_child(timer)
	
	var _ret = timer.connect("timeout", self, "on_timeout")

func _process(delta):
	$Label.rect_position = get_viewport().get_camera().unproject_position(global_transform.origin + Vector3.UP * 1.5)
	$Label.text = str(strength)
	var randVal = randi() % 100 * anger
	var randVal2 = randi() % 100 * fear
	if(randVal < 75 ) :
		update_angryness(delta)
	if(randVal2 < 75) :
		update_terrless(delta)

func eject():
	emit_signal("ejected", self)

func update_angryness(delta):
	var randVal = randf()
	if(terrless < 90):
		if(angryness>90) :
			luggage_ejectable = false
			strength = saved_strength * 2
		else:
			luggage_ejectable = true
			strength = saved_strength
	if(angryness >0) :
		angryness -= (randVal / anger) * delta * 0.01
	
func update_terrless(delta):
	var randVal = randf()
	if(terrless>90) :
		protector = 0
		strength = saved_strength / 2
	else:
		protector = saved_protector
		strength = saved_strength
	if(terrless >0) :
		terrless -= (randVal / fear) * delta * 0.01
	
func ejected_passenger():
	var randVala = randi() % 100 * anger
	var randValf = randi() % 100 * fear
	if(randVala > 50 ) :
		var randVal = randf()
		angryness += (randVal * anger) * 0.1
	if(randValf > 50 ) :
		var randVal = randf()
		terrless += (randVal * fear) * 0.1

func ejected_luggage():
	if(!tried):
		timer.start(5.0)
		tried = true
	else:
		return
	
	var randProtect = randi() % 100 * protector
	if(luggage_ejectable && randProtect < 50):
		GameManager.object_thrown(luggage.settings["weight"])
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
		 

func on_timeout():
	tried = false

func _on_Area_body_entered(body):
	if body as Player:
		body.add_near_passenger(self)

func _on_Area_body_exited(body):
	if body as Player:
		body.remove_near_passenger(self)
