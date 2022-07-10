extends Spatial

func _ready():
	call_deferred("init_progression_manager")

func init_progression_manager():
	$ProgressionManager.initialize()
