extends Node

signal current_load_updated

export(NodePath) var game_ui_path

var level
var game_ui_instance
var game_end_instance
var anger
var lift
var current_load: float = 0
var passengers: Array = []

func _process(delta):
	update_global_anger(delta)
	update_global_lift(delta)
	passengers.clear()

func clear_ui_instances():
	game_ui_instance = null
	game_end_instance = null

func game_over():
	game_end_instance.game_end(false)
	clear_ui_instances()

func win():
	game_end_instance.game_end(true)
	clear_ui_instances()

func update_global_anger(delta):
	if(game_ui_instance == null):
		return
	anger = game_ui_instance.get_stress()
	anger = anger - 0.1 * delta
	game_ui_instance.update_stress(anger)
	if(anger >= 90):
		return
	
func update_global_lift(delta):
	if(game_ui_instance == null):
		return
	lift = game_ui_instance.get_lift()
	lift = lift - 0.1 * delta
	game_ui_instance.update_lift(lift)
	if lift <= 0:
		game_over()

func object_thrown(weight):
	if(game_ui_instance == null || anger >= 100):
		return
	anger = game_ui_instance.get_stress()
	anger = anger + 10 * weight
	lift = game_ui_instance.get_lift()
	lift = lift + 0.9 * weight
	game_ui_instance.update_lift(lift)
	game_ui_instance.update_stress(anger)

func update_current_charge():
	current_load = 0
	for passenger in passengers:
		current_load += passenger.get_weight()
	emit_signal("current_load_updated", current_load)

func register_passenger(passenger: Node):
	var _err = passenger.connect("ejected", self, "unregister_passenger")
	current_load += passenger.get_weight()
	passengers.push_back(passenger)
	emit_signal("current_load_updated", current_load)

func unregister_passenger(passenger: Node):
	current_load -= passenger.get_weight()
	passengers.erase(passenger)
	emit_signal("current_load_updated", current_load)
	
func update_passenger_angry():
	for passenger in passengers:
		if(passenger != null):
			passenger.ejected_passenger()
#func anger_for_all_passengers():
	#var passengers = level.get_tree().get_nodes_in_group("passengers")
	#for passenger in passengers:
	#	passenger.connect("ejected", self, "_on_Passenger_ejected_anger")

