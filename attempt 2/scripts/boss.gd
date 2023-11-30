extends EnemyBase

func _on_arena_door_2_door_closed():
	set_physics_process (true)
	
func _ready():
	set_physics_process (false)
	wall_detector = $wall_detector
	texture = $texture
	anim.animation_finished.connect(kill_boss_enemy)

func _physics_process(delta):
	_aply_gravity(delta)
	movement(delta)
	flip_direction()
	


func _on_anim_animation_finished(anim_name):
	if anim_name == "hurt":
		anim.play("idle")
	
	
#	else anim_name == "die":
#		get_node("collision").set_deferred("disabled", true)


func _on_boss_died():
	get_node("Hitbox/collision").set_deferred("disabled", true)
