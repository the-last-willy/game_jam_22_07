extends Panel
class_name DialogUI

export var text : String = ""
export var text_character_speed : float = 5

var current_char_display_timer : float = 0
var current_char_id : int = 0
var currently_reading : bool = false
var wait_time_after_reading : float = 3
var wait_delta = 0
# Called when the node enters the scene tree for the first time.

func _ready():
	GameManager.dialog_ui = self

func start_reading(_text : String = ""):
	if text != "":
		text = _text
	$Label.text = ""
	visible = true
	current_char_display_timer = 0
	current_char_id = 0
	currently_reading = true
	wait_delta = wait_time_after_reading

func stop_reading():
	currently_reading = false
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currently_reading:
		if current_char_display_timer <= 0:
			$Label.text += text.substr(current_char_id, 1)
			current_char_id += 1
			current_char_display_timer = 1
		elif current_char_id >= text.length():
			if wait_delta > 0:
				wait_delta -= delta
			else:
				wait_delta = wait_time_after_reading
				stop_reading()
		else:
			current_char_display_timer	-= delta * text_character_speed
