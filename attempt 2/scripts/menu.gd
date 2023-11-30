extends Control

func _ready():
	Globals.coins = 0
	Globals.score = 0
	Globals.player_life = 3

func _on_start_btn_pressed():
	get_tree().change_scene_to_file("res://levels/world.tscn")

func _on_controls_btn_pressed():
	get_tree().change_scene_to_file("res://prefabs/Controls.tscn")

func _on_quit_btn_pressed():
	get_tree().quit()

func _on_texture_button_pressed():
	print("Button pressed")
	OS.shell_open("https://translate.google.com.br")


func _on_highscore_btn_pressed():
	get_tree().change_scene_to_file("res://prefabs/ranking.tscn")


func _on_credits_btn_pressed():
	get_tree().change_scene_to_file("res://prefabs/credits.tscn")
