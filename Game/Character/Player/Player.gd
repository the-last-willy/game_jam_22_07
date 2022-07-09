extends KinematicBody

export var speed = 14

var velocity = Vector3.ZERO

export var fall_acceleration = 75

func _physics_process(delta):
	
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction = Input.get_vector("move_right")
	if Input.is_action_pressed("move_left"):
		direction = Input.get_vector("move_left")
	if Input.is_action_pressed("move_back"):
		direction = Input.get_vector("move_back")
	if Input.is_action_pressed("move_forward"):
		direction = Input.get_vector("move_forward")

	 if direction != Vector3.ZERO:
		$Pivot.look_at(translation + direction, Vector3.UP)
		
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)
