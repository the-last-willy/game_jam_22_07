extends Spatial

class_name SpawnPerso

var character:Character = Character.new()

var speed: float
var strength: float
var fear: float
var anger: float
var protector: float
var weight: float
var passenger = preload("res://Game/Character/Passenger/Passenger.tscn")

const LuggagePlacement = preload("res://Game/Props/Luggage/LuggagePlacement.gd").LuggagePlacement

var luggage_placement = LuggagePlacement.left
var luggage_scene = load("res://Game/Props/Luggage/Luggage.tscn")

var luggage_placement_node : Spatial

func _ready() :
	luggage_placement = get_parent().luggage_placement
	luggage_placement_node = get_parent().get_node("LuggagePlacement")
	var passenger_instance = spawn_passenger()
	if passenger_instance != null:
		spawn_luggage(passenger_instance)

func spawn_luggage(passenger_instance : Passenger):
	var luggage = luggage_scene.instance()
	match(luggage_placement):
		LuggagePlacement.left:
			luggage.transform = luggage_placement_node.get_node("Left").transform
		LuggagePlacement.right:
			luggage.transform = luggage_placement_node.get_node("Right").transform
	add_child(luggage)
	passenger_instance.set_luggage(luggage)

func spawn_passenger() -> Passenger:
	var  is_spawned = randi() % 1000
	
	if is_spawned < 250:
		return null
		
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
	passenger_instance.set_weight(weight)
	return passenger_instance

func generate_random() :
	character.init(randi() % 4, randi() % 3,randi() % 3, randi() % 2, randi() % 7)
	
	var temper = character.get_temper()
	var caliber = character.get_caliber()
	var status = character.get_status()
	#var special = character.get_special()
	
	speed = temper["speed"] * caliber["speed"] * status["speed"]
	strength = temper["strength"] * caliber["strength"] * status["strength"]
	fear = temper["fear"] * caliber["fear"] * status["fear"]
	anger = temper["anger"] * caliber["fear"] * status["fear"]
	protector = temper["protector"] * caliber["protector"] * status["protector"]
	weight = caliber["weight"]
	
	
