extends Panel

var main_menu = load("res://Game/Scenes/Main/Main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.game_end_instance = self
	visible = false

func game_end(win : bool):
	visible = true
	get_tree().paused = true
	if win:
		$VBoxContainer/Label.text = "You win"
	else:
		$VBoxContainer/Label.text = "You lose"
	$VBoxContainer/Exit.grab_focus()

func exit_to_main_menu():
	get_tree().paused = false
	var _error_code = get_tree().change_scene_to(main_menu)


func _on_ProgressionManager_current_load_updated(val):
	pass # Replace with function body.


func _on_ProgressionManager_supported_load_updated(val):
	pass # Replace with function body.
