extends Camera

var cur_time = 0

func camera_tremble():
	translation.y += sin( cur_time * 10  ) * 0.001 
	translation.y += sin( cur_time * -20  ) * 0.002 
	translation.x += cos( cur_time * 10  ) * 0.001 
	translation.x += cos( cur_time * -70  ) * 0.002 
	translation.z += cos( cur_time * -30  ) * 0.001
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cur_time += delta
	camera_tremble()
