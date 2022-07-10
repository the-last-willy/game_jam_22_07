extends Node

signal current_load_updated(val)
signal height_updated(val)
signal inclination_updated(val)
signal plane_arrived
signal plane_crashed
signal progress_updated(val)
signal supported_load_updated(val)

var current_load: Array = [0, 0]
var height: Array = [1, 1]
var inclination = [0, 0]
var progress: float = 1
var supported_load: Array = [0, 0]

var registered_luggages: Array = []
var registered_passengers: Array = []

func _ready():
	GameManager.progression_manager_instance = self
	
	var _ignored = connect("plane_crashed", GameManager, "game_over")
	_ignored = connect("plane_arrived", GameManager, "win")

func initialize():
	for passenger in GameManager.passengers:
		register_passenger(passenger)
		if passenger.luggage != null:
			register_luggage(passenger.luggage)
		
	supported_load[1] = current_load[1] - 5
	
	current_load[0] = current_load[1]
	supported_load[0] = supported_load[1]

func _process(_delta):
	progress = 1 - $GameDuration.time_left / 600.0 + .90
	var target_inclination = current_load[0] - supported_load[0]
	inclination[1] = max(0, inclination[0] + (target_inclination - inclination[0]) / 300)
	height[1] -= inclination[0] / 25000
	
	if progress >= 1:
		emit_signal("plane_arrived")
		return
	elif height[1] <= 0:
		emit_signal("plane_crashed")
	else:
		emit_signal("current_load_updated", current_load[1])
		current_load[0] = current_load[1]
			
		if height[0] != height[1]:
			emit_signal("height_updated", height[1])
			height[0] = height[1]
			
		if inclination[0] != inclination[1]:
			emit_signal("inclination_updated", inclination[1])
			inclination[0] = inclination[1]
			
		emit_signal("progress_updated", progress)
		
		emit_signal("supported_load_updated", supported_load[1])
		supported_load[0] = supported_load[1]

func register_luggage(luggage: Node):
	var _ignored = luggage.connect("ejected", self, "unregister_luggage")
	current_load[1] += luggage.get_weight()
	registered_luggages.push_back(luggage)

func unregister_luggage(luggage: Node):
	current_load[1] -= luggage.get_weight()
	registered_luggages.erase(luggage)

func register_passenger(passenger: Node):
	var _ignored = passenger.connect("ejected", self, "unregister_passenger")
	current_load[1] += passenger.get_weight()
	registered_passengers.push_back(passenger)

func unregister_passenger(passenger: Node):
	current_load[1] -= passenger.get_weight()
	registered_passengers.erase(passenger)
	
func update_load(_load : float):
	supported_load[1] += _load;
