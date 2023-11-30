extends Area2D

var coin_value := 1
@onready var coin_sfx = $coin_sfx as AudioStreamPlayer


func _process(delta):
	pass


func _on_body_entered(body):
	$anim.play("collect")
	coin_sfx.play()
	await $collision.call_deferred("queue_free")
#	Globals.coins += coin_value
	Globals.collect_coin()




func _on_anim_animation_finished():
	queue_free()
