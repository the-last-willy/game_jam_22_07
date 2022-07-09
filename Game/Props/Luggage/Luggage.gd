extends Spatial

export(PackedScene) var luggage_configuration;

class_name Luggage

var settings : Dictionary;

func _ready():
	settings = luggage_configuration.instance().random_luggage_settings()
	var model_scene = load(settings.model_path)
	add_child(model_scene.instance())

func get_handle_position():
	pass
