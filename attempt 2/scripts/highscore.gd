extends Control

@export_category("objects")
@export var _name: LineEdit = null
@export var _score: Label = null
@export var _score_cointainer: Control = null


func _on_submit_btn_pressed():
	SilentWolf.Scores.save_score(_name.text, int (_score.text))
	_name.clear()
	get_tree().change_scene_to_file("res://prefabs/loading_screen.tscn")
	
	



func _on_retry_btn_pressed():
	get_tree().change_scene_to_file("res://prefabs/menu.tscn")
