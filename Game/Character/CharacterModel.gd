extends Spatial

onready var anim_tree = $AnimationTree

func play_animation(name : String):
	anim_tree.get("parameters/playback").travel(name)
	
func force_play_animation(name : String):
	anim_tree.get("parameters/playback").start(name)
