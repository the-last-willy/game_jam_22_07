extends Panel


var level = preload("res://Game/Scenes/Level/Level.tscn")

func _ready():
	$VBoxContainer/Play.grab_focus()

func _on_Quit_pressed():
	get_tree().quit()


func _on_Play_pressed():
	var _error_code = get_tree().change_scene_to(level)
		
