extends Node


export(NodePath) var game_ui_path

var game_ui_instance
var game_end_instance
var anger
var lift

func _process(delta):
	update_global_anger(delta)
	update_global_lift(delta)

func game_over():
	game_end_instance.game_end(false)

func win():
	game_end_instance.game_end(true)

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
	if(game_ui_instance == null || anger >= 100):
		return
	anger = game_ui_instance.get_stress()
	anger = anger + 10 * weight
	lift = game_ui_instance.get_lift()
	lift = lift + 0.9 * weight
	game_ui_instance.update_lift(lift)
	game_ui_instance.update_stress(anger)
