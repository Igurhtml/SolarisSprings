extends Node2D

@onready var camera = $"." as Camera2D


func _ready():
	camera.set_process(false)

func _on_activate_camera():
	camera.set_process(true)

func _on_trigger_player_entered():
	_on_activate_camera()


func _on_trigger_body_entered(body):
	_on_activate_camera()
