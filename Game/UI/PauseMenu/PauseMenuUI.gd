extends Panel

var is_paused : bool = false

var main_menu = load("res://Game/Scenes/Main/Main.tscn")

func resume():
	is_paused = false
	get_tree().paused = false
	visible = false
	
func pause():
	is_paused = true
	get_tree().paused = true
	visible = true
	$HBoxContainer/Resume.grab_focus()

func exit_to_main_menu():
	resume()
	var _error_code = get_tree().change_scene_to(main_menu)
	
func quit():
	get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready():
	resume()

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		if is_paused:
			resume()
		else:
			pause()
