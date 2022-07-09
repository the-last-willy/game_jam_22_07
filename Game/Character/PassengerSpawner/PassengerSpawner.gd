extends Spatial

class_name SpawnPerso

var character:Character = Character.new()

var speed: float
var strength: float
var fear: float
var anger: float
var protector: float
var passenger = preload("res://Game/Character/Passenger/Passenger.tscn")

func _ready() :
	var  is_spowned = randi() % 1000
	
	if is_spowned < 250:
		return
		
	generate_random()
	
	var path = "res://Game/Character/Passenger/Models/PassengerModel" + character.get_caliber_type()  + ".tscn"
	
	var passenger_type = load(path)
	
	var passenger_instance = passenger.instance()
	
	passenger_instance.add_child(passenger_type.instance())
	
	get_parent().call_deferred("add_child", passenger_instance)
	
	passenger_instance.rotation_degrees = Vector3(0, 90, 0)
	
	passenger_instance.set_speed(speed)
	passenger_instance.set_strength(strength)
	passenger_instance.set_fear(fear)
	passenger_instance.set_anger(anger)
	passenger_instance.set_protector(protector)
	
	
	
	
func generate_random() :
	character.init(randi() % 4, randi() % 3,randi() % 3, randi() % 2, randi() % 7)
	
	var temper = character.get_temper()
	var caliber = character.get_caliber()
	var status = character.get_status()
	var special = character.get_special()
	
	speed = temper["speed"] * caliber["speed"] * status["speed"]
	strength = temper["strength"] * caliber["strength"] * status["strength"]
	fear = temper["fear"] * caliber["fear"] * status["fear"]
	anger = temper["anger"] * caliber["fear"] * status["fear"]
	protector = temper["protector"] * caliber["protector"] * status["protector"]
	
	
