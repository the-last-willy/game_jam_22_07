extends KinematicBody

const CONTROLLER_DEADZONE = 0.2

const CONTROL_MODE_KEYBOARD : int = 0
const CONTROL_MODE_CONTROLLER : int = 1

var control_mode := CONTROL_MODE_KEYBOARD

var move_speed : float = 3.0

var velocity : Vector3 = Vector3.ZERO

var input_camera_space : bool = false

func _physics_process(delta):
	
	var input_dir = Input.get_vector(
		"move_left", "move_right", 
		"move_backward", "move_forward",
		CONTROLLER_DEADZONE
	)
	
	var move_dir : Vector3
	
	if control_mode == CONTROL_MODE_CONTROLLER:
		var cam_forward : Vector3 = -get_viewport().get_camera().global_transform.basis.z
		var cam_right : Vector3 = get_viewport().get_camera().global_transform.basis.x
		move_dir = input_dir.x * cam_right + input_dir.y * cam_forward
		move_dir = Vector3(move_dir.x, 0, move_dir.z)
		if !move_dir.is_equal_approx(Vector3.ZERO):
			move_dir = move_dir.normalized()
	else:
		move_dir = Vector3(-input_dir.x, 0, input_dir.y)
	
	if !move_dir.is_equal_approx(Vector3.ZERO):
		velocity = move_and_slide(move_dir * move_speed)
		look_at(global_transform.origin + move_dir, Vector3.UP)

func _input(event : InputEvent) -> void:
	if ((event is InputEventJoypadButton) or 
		(event is InputEventJoypadMotion and event.axis_value > CONTROLLER_DEADZONE)):
		control_mode = CONTROL_MODE_CONTROLLER
	elif (event is InputEventKey) or (event is InputEventMouseButton):
		control_mode = CONTROL_MODE_KEYBOARD
