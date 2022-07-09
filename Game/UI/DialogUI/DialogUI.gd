extends Panel

export var text : String = ""
export var text_character_speed : float = 5

var current_char_display_timer : float = 0
var current_char_id : int = 0
var currently_reading : bool = false
# Called when the node enters the scene tree for the first time.

func start_reading():
	current_char_display_timer = 0
	current_char_id = 0
	currently_reading = true
	
func _ready():
	start_reading()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currently_reading:
		var text_defilment_multiplier : float = 1
		if Input.is_action_pressed("ui_accept"):
			text_defilment_multiplier = 3
		
		if current_char_display_timer <= 0:
			$Label.text += text.substr(current_char_id, 1)
			current_char_id += 1
			current_char_display_timer = 1
		elif current_char_id >= text.length():
			currently_reading = false
		else:
			current_char_display_timer	-= delta * text_character_speed * text_defilment_multiplier
	else:
		if Input.is_action_just_pressed("ui_accept"):
			queue_free()
