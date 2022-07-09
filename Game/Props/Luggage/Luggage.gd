extends Spatial

export(PackedScene) var model

var LuggageSettings = load("res://Game/Prop/Luggage/LuggageSettings.gd")

class_name Luggage

var settings : Dictionary;

func _ready():
	settings = LuggageSettings.random_luggage_settings()
	var model_scene = load("res://Game/Prop/Luggage/Model/LuggageModelHeavy.tscn")
	assert(model_scene != null)
	add_child(model.instance())

func get_handle_position():
	pass
