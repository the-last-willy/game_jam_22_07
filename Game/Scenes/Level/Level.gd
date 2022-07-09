extends Spatial

func _ready():
	call_deferred("init_level")

func init_level():
	GameManager._on_Level_ready()
