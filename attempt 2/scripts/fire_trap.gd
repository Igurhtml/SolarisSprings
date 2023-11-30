extends Area2D



func _on_body_entered(body):
	if body.name == "player" && body.has_method("take_damage"):
		body.take_damage(Vector2(0, -250))


func _on_start_timer_timeout():
	$anim.play("on")
	$fire_col.set_deferred("disabled", false)


func _on_stop_timer_timeout():
	$anim.play("off")
	$fire_col.set_deferred("disabled", true)
