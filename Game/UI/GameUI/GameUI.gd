extends Control

func update_stress(value):
	$StressBar.value = value
	
func update_lift(value):
	$PlaneLiftBar.value = value

func get_stress():
	return $StressBar.value
	
func get_lift():
	return $PlaneLiftBar.value
	
