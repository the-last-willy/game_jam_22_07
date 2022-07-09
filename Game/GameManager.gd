extends Node

func game_over():
	get_tree().get_node("GameEndUI").game_end(false)

func win():
	get_tree().get_node("GameEndUI").game_end(true)
