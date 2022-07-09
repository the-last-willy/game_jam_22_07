extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var strength : float = 60
var loss : float = 30
var press : float = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	strength -= loss * delta
	if Input.is_action_just_pressed("ui_accept"):
		strength += press
	$ProgressBar.value = strength