extends Control

func _on_restart_btn_pressed():
	get_tree().change_scene_to_file("res://prefabs/menu.tscn")


func _on_quit_btn_pressed():
	get_tree().quit()
