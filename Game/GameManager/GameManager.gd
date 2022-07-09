extends Node


export(NodePath) var game_ui_path

var game_ui_instantiate
var anger
var lift

func _ready():
	game_ui_instantiate = get_parent().get_node("GameUI")

func _process(delta):
	update_global_anger(delta)
	update_global_lift(delta)

func game_over():
	get_parent().get_node("GameEndUI").game_end(false)

func win():
	get_parent().get_node("GameEndUI").game_end(true)

func update_global_anger(delta):
	if(game_ui_instantiate == null):
		return
	var anger = game_ui_instantiate.get_stress()
	anger = anger - 0.1 * delta
	game_ui_instantiate.update_stress(anger)
	if(anger >= 100):
		return
	
func update_global_lift(delta):
	if(game_ui_instantiate == null):
		return
	var lift = game_ui_instantiate.get_lift()
	lift = lift - 0.10 * delta
	game_ui_instantiate.update_lift(lift)
	if lift <= 0:
		game_over()

func object_thrown(weight):
	var anger = game_ui_instantiate.get_stress()
	anger = anger + 5 * weight
	var lift = game_ui_instantiate.get_lift()
	lift = lift + 5 * weight
	game_ui_instantiate.update_lift(lift)
	game_ui_instantiate.update_stress(anger)
	
	
