extends Node

func _on_replay_butt_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
	#TRANSICION.change_scene_loc("res://world.tscn")
	get_tree().paused = false

func _on_quit_butt_pressed():
	get_tree().quit()
