extends Node

export(NodePath) var game_ui_path

var level
var game_ui_instance
var game_end_instance
var progression_manager_instance
var dialog_ui : DialogUI
var anger
var passengers: Array = []

func _process(delta):
	update_global_anger(delta)

func clear_instances():
	game_ui_instance = null
	game_end_instance = null
	dialog_ui.stop_reading()
	passengers.clear()

func game_over():
	game_end_instance.game_end(false)
	clear_instances()

func win():
	game_end_instance.game_end(true)
	clear_instances()

func update_global_anger(delta):
	if(game_ui_instance == null):
		return
	anger = game_ui_instance.get_stress()
	anger = anger - 0.1 * delta
	game_ui_instance.update_stress(anger)
	if(anger >= 90):
		return

func object_thrown(weight):
	if(game_ui_instance == null || anger >= 100):
		return
	anger = game_ui_instance.get_stress()
	anger = anger + 10 * weight
	game_ui_instance.update_stress(anger)

func register_passenger(passenger: Node):
	passenger.connect("ejected", self, "unregister_passenger")
	passengers.push_back(passenger)

func unregister_passenger(passenger: Node):
	passengers.erase(passenger)

func update_passenger_angry():
	for passenger in passengers:
		passenger.ejected_passenger()
		if(passenger != null):
			passenger.ejected_passenger()
			
func update_passengers_with_event():
	for passenger in passengers:
		if(passenger != null):
			pass

