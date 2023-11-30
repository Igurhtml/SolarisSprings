extends Area2D

signal PlayerEntered

func _on_body_entered(body):
	if body.name == "player":
		emit_signal("PlayerEntered")
		queue_free()
