extends Area2D

@onready var transition = $"../transition"
@export var next_level : String = ""
@onready var audio_stream_player = $AudioStreamPlayer

func _on_body_entered(body):
	if body.name == "player" and !next_level == "":
		transition.change_scene(next_level)
	else:
		print("no")
	audio_stream_player.play()


	
	
	
