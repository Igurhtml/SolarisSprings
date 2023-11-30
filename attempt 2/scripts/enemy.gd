extends CharacterBody2D
class_name EnemyBase

const SPEED = 1700.0
const ANGRY_SPEED = 2700.0 
const JUMP_VELOCITY = -400.0

signal boss_died

@onready var anim := $anim 
@export var enemy_score := 100
@export var health = 1
@onready var enemy_hurt = $enemy_hurt

var wall_detector
var texture
var move_direction := -1
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var can_spawn = false
var spawn_instance : PackedScene
var spawn_instance_position
var current_speed = SPEED 

func _aply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
func movement(delta):
	velocity.x = move_direction * current_speed * delta 
	move_and_slide()
	
func flip_direction():
	if $wall_detector.is_colliding():
		move_direction *= -1
		$wall_detector.scale.x *= -1
	if move_direction == 1:
		texture.flip_h = true
	else:
		texture.flip_h = false

func kill_ground_enemy(anim_name: StringName) -> void:
	kill_and_score()
		
func kill_air_enemy():
	kill_and_score()
	
func kill_boss_enemy(anim_name: StringName) -> void:
	kill_and_score_boss()
	

func kill_and_score_boss(): 
	health -= 1
	$hurt_enemies.play()
	if health <= 3: 
		$anim.play("angry_run")
		current_speed = ANGRY_SPEED 
	if health < 1:
		Globals.score += enemy_score
		Globals.highscore += enemy_score
		set_physics_process (false)
		$anim.play("die")
		await $anim.animation_finished
		queue_free()
		emit_signal("boss_died")
		
func kill_and_score():
	health -= 1
	if health < 1: 
		print("kill_and_score called")
		print("enemy_score: ", enemy_score)
		print("Globals.score before: ", Globals.score)
		queue_free()
		Globals.score += enemy_score 
		Globals.highscore += enemy_score
	if can_spawn:
		spawn_new_enemy()
	
func spawn_new_enemy():
	var instance_scene = spawn_instance.instantiate()
	get_tree().root.add_child(instance_scene)
	instance_scene.global_position = spawn_instance_position.global_position
