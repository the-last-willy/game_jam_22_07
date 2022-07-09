extends Spatial

class_name SpawnPerso

var character:Character = Character.new()

var speed: float
var strength: float
var fear: float
var anger: float
var protector: float

func _init() :
	generate_random()
	
	
func generate_random() :
	character.init(randi() % 4, randi() % 4,randi() % 2, randi() % 2, randi() % 7)
	
	var temper = character.get_temper()
	var caliber = character.get_caliber()
	var status = character.get_status()
	var special = character.get_special()
	
	speed = temper["speed"] * caliber["speed"] * status["speed"]
	strength = temper["strength"] * caliber["strength"] * status["strength"]
	fear = temper["fear"] * caliber["fear"] * status["fear"]
	anger = temper["anger"] * caliber["fear"] * status["fear"]
	protector = temper["protector"] * caliber["protector"] * status["protector"]
	
	
