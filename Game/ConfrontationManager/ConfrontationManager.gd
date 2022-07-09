extends Node

onready var main_camera : Camera = $MainCamera
onready var confrontation_camera : Camera = $ConfrotationCamera

onready var opponent1_pos : Spatial = $Oppenent1Pos
onready var opponent2_pos : Spatial = $Oppenent2Pos

onready var button_smasher : ButtonSmasher = $ButtonMasher

var player : Player = null
var opponent : Spatial = null

var confronting : bool = false

var base_strength : float = 30
var base_loss : float = 30
var base_press_strength : float = 10

var strength : float = base_strength
var loss : float = base_loss
var press_strength : float = base_press_strength

func _ready():
	pass

func _process(delta):
	if !confronting:
		return
	
	strength -= loss * delta
	if Input.is_action_just_pressed("grab"):
		strength += press_strength
	button_smasher.set_value(strength)
	
	if strength <= 0.0 || strength >= 100.0:
		confronting = false
		player.confronting = false
		
		if strength <= 0.0:
			player.queue_free()
			get_tree().call_group("GameManager", "game_over")
		else:
			opponent.queue_free()
			get_tree().call_group("GameManager", "object_thrown",opponent.weight)
			
		player = null
		opponent = null
		
		button_smasher.visible = false
		main_camera.current = true
		confrontation_camera.current = false

func confront(p_player : Spatial, p_opponent : Spatial) -> void:
	player = p_player
	opponent = p_opponent
	
	confronting = true
	
	main_camera.current = false
	confrontation_camera.current = true
	
	button_smasher.visible = true
	
	strength = base_strength
	loss = base_loss * opponent.strength
	
	player.global_transform = opponent1_pos.global_transform
	opponent.global_transform = opponent2_pos.global_transform
	
