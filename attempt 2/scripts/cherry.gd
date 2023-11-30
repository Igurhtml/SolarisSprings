extends EnemyBase

func _ready():
	wall_detector = $wall_detector
	texture = $texture
	anim.animation_finished.connect(kill_ground_enemy)

func _physics_process(delta):
	_aply_gravity(delta)
	movement(delta)
	flip_direction()


func _on_anim_animation_finished(anim_name):
	pass # Replace with function body.
