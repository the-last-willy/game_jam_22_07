extends Node

const luggage_settings : Dictionary = {
	"light": {
		"model_path": "res://Game/Props/Luggage/Model/LuggageModelLight.tscn",
		"name": "light",
		"spawn_probability": 2.0/6,
		"weight": .2
	},
	"medium" : {
		"model_path": "res://Game/Props/Luggage/Model/LuggageModelMedium.tscn",
		"name": "medium",
		"spawn_probability": 3.0/6,
		"weight": .4
	},
	"heavy": {
		"model_path": "res://Game/Props/Luggage/Model/LuggageModelHeavy.tscn",
		"name": "heavy",
		"spawn_probability": 1.0/6,
		"weight": .6
	}
}

func random_luggage_settings():
	var r = randf()
	for settings in luggage_settings.values():
		if r >= settings.spawn_probability:
			r -= settings.spawn_probability
		else:
			return settings
	assert(false, "The sum of probabilities is less than 1, you little shit.")
