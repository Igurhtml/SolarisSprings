extends Control

func _ready():
	await SilentWolf.Scores.sw_save_score_complete
	get_tree().change_scene_to_file("res://prefabs/ranking.tscn")
