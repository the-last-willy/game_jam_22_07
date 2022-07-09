extends Spatial



export(LuggagePlacement) var luggage_placement = LuggagePlacement.left

var luggage_scene = load("res://Game/Props/Luggage/Luggage.tscn")


func _ready():
	luggage = luggage_scene.instance()
	match(luggage_placement):
		LuggagePlacement.left:
			luggage.transform = $LuggagePlacement/Left.transform
		LuggagePlacement.right:
			luggage.transform = $LuggagePlacement/Right.transform
	add_child(luggage)
