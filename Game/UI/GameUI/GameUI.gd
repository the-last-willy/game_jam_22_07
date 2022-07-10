extends Control

func _ready():
	GameManager.game_ui_instance = self

func update_stress(value):
	$StressBar.value = value
	
func update_lift(value):
	$PlaneLiftBar.value = value

func get_stress():
	return $StressBar.value
	
func get_lift():
	return $PlaneLiftBar.value
	
func _on_ProgressionManager_inclination_updated(_val):
	pass

func _on_ProgressionManager_height_updated(val):
	$Height.text = "Height: %f" % val
	$PlaneHeightBar.value = val

func _on_ProgressionManager_supported_load_updated(val):
	$SupportedLoad.text = "SupLoad: %f" % val

func _on_ProgressionManager_progress_updated(val):
	$Progress.text = "Progress: %f" % val

func _on_ProgressionManager_current_load_updated(val):
	$CurrentLoad.text = "CurLoad: %f" % val
