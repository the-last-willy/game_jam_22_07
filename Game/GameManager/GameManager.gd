extends Node

var game_ui = preload("res://Game/UI/GameUI/GameUI.tscn")

var game_ui_instantiate

func _ready():
	game_ui_instantiate = game_ui.instance()
	add_child(game_ui_instantiate)

func _process(delta):
	update_global_anger(delta)
	update_global_lift(delta)

func game_over():
	get_parent().get_node("GameEndUI").game_end(false)

func win():
	get_parent().get_node("GameEndUI").game_end(true)

func update_global_anger(delta):
	var anger = game_ui_instantiate.get_child(0).get_value()
	anger = anger - 0.10 * delta
	game_ui_instantiate.get_child(0).set_value(anger)
	if(anger >= 100):
		return
	
func update_global_lift(delta):
	var lift = game_ui_instantiate.get_child(1).get_value()
	lift = lift - 0.10 * delta
	game_ui_instantiate.get_child(1).set_value(lift)
	if lift <= 0:
		game_over()

func object_thrown(weight):
	var anger = game_ui_instantiate.get_child(0).get_value()
	anger = anger + 5 * weight
	var lift = game_ui_instantiate.get_child(1).get_value()
	lift = lift + 5 * weight
	game_ui_instantiate.get_child(1).set_value(lift)
	game_ui_instantiate.get_child(0).set_value(anger)
