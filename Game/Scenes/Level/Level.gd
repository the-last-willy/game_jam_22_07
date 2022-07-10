extends Spatial

func _ready():
	GameManager.level = self
	call_deferred("init_progression_manager")

func init_progression_manager():
	$ProgressionManager.initialize()
