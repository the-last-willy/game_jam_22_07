extends Spatial


func _on_Area_body_entered(body):
	if body as Player:
		body.add_near_passenger(self)


func _on_Area_body_exited(body):
	if body as Player:
		body.remove_near_passenger(self)
