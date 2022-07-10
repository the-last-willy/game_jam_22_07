extends Spatial

onready var main_camera : Camera = $MainCamera
onready var sequence_camera : Camera = $SequenceCamera

# Confronting stuff
onready var opponent1_pos : Spatial = $Oppenent1Pos
onready var opponent2_pos : Spatial = $Oppenent2Pos

onready var button_smasher : ButtonSmasher = $ButtonMasher

var player : Player = null
var opponent : Spatial = null

onready var opponent_last_pos : Transform = opponent2_pos.global_transform

var confronting : bool = false

var base_strength : float = 30
var base_loss : float = 30
var base_press_strength : float = 10

var strength : float = base_strength
var loss : float = base_loss
var press_strength : float = base_press_strength

# Luggage throwing stuff

var luggage_throwing : bool = false


var timer : Timer

var anim

func _ready():
	timer = Timer.new()
	timer.one_shot = true
	
	add_child(timer)
	anim = get_parent().get_node("AircraftCabin").get_node("Door").get_node("AnimationPlayer")
	
	var _ret = timer.connect("timeout", self, "on_timeout")

func _process(delta):
	if confronting:
		strength -= loss * delta
		if Input.is_action_just_pressed("grab_passenger"):
			strength += press_strength
		button_smasher.set_value(strength)
		
		if strength <= 0.0 || strength >= 100.0:
			if strength <= 0.0:
				player.queue_free()
				GameManager.game_over()
				player = null
			else:
				var luggage_weight = 0
				if(opponent.luggage != null):
					luggage_weight = opponent.luggage.settings["weight"]
					opponent.luggage.queue_free()
					opponent.luggage = null
				opponent.eject()
				opponent.queue_free()
				GameManager.object_thrown(opponent.weight + luggage_weight)
				GameManager.update_passenger_angry()
				opponent = null
			
			stop_confront()

func confront(p_player : Spatial, p_opponent : Spatial) -> void:
	player = p_player
	opponent = p_opponent
	
	confronting = true
	
	main_camera.current = false
	sequence_camera.current = true
	
	button_smasher.visible = true
	
	strength = base_strength
	loss = base_loss * opponent.strength
	
	opponent_last_pos = opponent.global_transform
	
	player.global_transform = opponent1_pos.global_transform
	opponent.global_transform = opponent2_pos.global_transform
	
	timer.start(10.0)
	
	anim.play("open")

func throw_luggage(p_player : Spatial):
	luggage_throwing = true
	main_camera.current = false
	sequence_camera.current = true
	anim.play("open")
	player = p_player
	timer.start(1.0)
	player.global_transform = opponent1_pos.global_transform

func stop_throw_luggage():
	anim.play("Close")
	main_camera.current = true
	sequence_camera.current = false
	luggage_throwing = false
	if player != null:
		player.confronting = false
		player = null

func stop_confront():
	anim.play("Close")
	confronting = false
	
	if player != null:
		player.confronting = false
		player = null
	
	if opponent != null:
		opponent.global_transform = opponent_last_pos
		opponent = null
	
	button_smasher.visible = false
	main_camera.current = true
	sequence_camera.current = false
	
	timer.stop()

func on_timeout():
	if confronting:
		stop_confront()
	if luggage_throwing:
		stop_throw_luggage()
