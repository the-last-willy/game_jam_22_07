extends Node

func game_over():
	get_parent().get_node("GameEndUI").game_end(false)

func win():
	get_parent().get_node("GameEndUI").game_end(true)
