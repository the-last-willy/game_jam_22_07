extends Node

signal current_charge_updated

export(NodePath) var game_ui_path

var level
var game_ui_instance
var game_end_instance
var anger
var lift
var current_charge: float = 0

func _on_Level_ready():
	connect_to_all_passengers()
	update_current_charge()

func _process(delta):
	update_global_anger(delta)
	update_global_lift(delta)

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
	if(anger >= 100):
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
	if(game_ui_instance == null):
		return
	anger = game_ui_instance.get_stress()
	anger = anger + 3 * weight
	lift = game_ui_instance.get_lift()
	lift = lift + 0.9 * weight
	game_ui_instance.update_lift(lift)
	game_ui_instance.update_stress(anger)

func connect_to_all_passengers():
	var passengers = level.get_tree().get_nodes_in_group("passengers")
	for passenger in passengers:
		passenger.connect("ejected", self, "_on_Passenger_ejected")

func update_current_charge():
	current_charge = 0
	for passenger in level.get_tree().get_nodes_in_group("passengers"):
		current_charge += passenger.get_weight()
	emit_signal("current_charge_updated", current_charge)

func _on_Passenger_ejected(ejected_passenger: Node):
	update_current_charge()
