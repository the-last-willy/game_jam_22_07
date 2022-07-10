extends TextureRect

export var text : String = ""
export var text_character_speed : float = 5
export var wait_time : float = 3

var current_char_display_timer : float = 0
var current_char_id : int = 0
var currently_reading : bool = false
var wait_delta = 0
# Called when the node enters the scene tree for the first time.

func start_reading( text_to_read = "" ):
	if text_to_read != "":
		text = text_to_read
		
	current_char_display_timer = 0
	current_char_id = 0
	currently_reading = true
	wait_delta = wait_time
	

func stop_reading():
	currently_reading = false
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currently_reading:
		var text_defilment_multiplier : float = 1
#		if Input.is_action_pressed("ui_accept"):
#			text_defilment_multiplier = 3
		
		if current_char_display_timer <= 0:
			$Label.text += text.substr(current_char_id, 1)
			current_char_id += 1
			current_char_display_timer = 1
		elif current_char_id >= text.length():
			if wait_time > 0:
				wait_time -= delta
			else:
				stop_reading()
		else:
			current_char_display_timer	-= delta * text_character_speed * text_defilment_multiplier
