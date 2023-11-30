extends StaticBody2D

signal doorClosed

func _on_trigger_player_entered():
	$anim.play("enable")
	emit_signal("doorClosed")


func _on_boss_boss_died():
	$anim.play("final")
