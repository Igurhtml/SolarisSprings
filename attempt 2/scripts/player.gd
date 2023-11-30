extends CharacterBody2D


const SPEED = 200.0
const JUMP_FORCE = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
var is_hurt := false
var knockback_vector := Vector2.ZERO
var direction 


@onready var animation := $anim as AnimatedSprite2D
@onready var remote_transform := $remote as RemoteTransform2D
@onready var jump_sfx = $jump_sfx as AudioStreamPlayer
@onready var hurt_sfx = $hurt_sfx as AudioStreamPlayer
@onready var destroy_sfx = preload("res://sounds/destroy_sfx.tscn")

signal player_has_died()

@onready var main_camera = get_node("camera")
@onready var camera_boss = get_node("camera_boss")

func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
		jump_sfx.play()
	elif is_on_floor():
		is_jumping = false
	direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0: 
		velocity.x = direction * SPEED
		animation.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	
	_set_state()
	move_and_slide()
	
	for plataforms in get_slide_collision_count():
		var collision = get_slide_collision(plataforms)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)

func _on_hurtbox_body_entered(body):
	if $ray_right.is_colliding():
		take_damage(Vector2(-200,-200))
	elif $ray_left.is_colliding():
		take_damage(Vector2(200,-200))
		
func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path
	
func stop_following_camera(camera_boss):
	remote_transform.remote_path = "camera_boss"


func take_damage_void (knockback_force := Vector2.ZERO, duration := 0.25):
	
	if Globals.player_life > 0:
		Globals.player_life -= 1
	else:
		queue_free()
		emit_signal("player_has_died")
		
		
func take_damage (knockback_force := Vector2.ZERO, duration := 0.25):
	
	if Globals.player_life > 0:
		Globals.player_life -= 1
		hurt_sfx.play()
		
	else:
		queue_free()
		emit_signal("player_has_died")
		
		
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		
		var knockback_tween = get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		animation.modulate = Color(1,0,0,1)
		knockback_tween.parallel().tween_property(animation, "modulate", Color(1,1,1,1), duration)
		
	is_hurt = true
	await get_tree().create_timer(.3).timeout
	is_hurt = false
		
func _set_state():
	var state = "idle"
	
	if !is_on_floor():
		state = "jump"
	elif direction != 0:
		state= "run"
		
	if is_hurt:
		state = "hurt"
		
	if animation.name != state:
		animation.play(state)
		
func _on_head_collider_body_entered(body):
	if body.has_method("break_sprite"):
		body.hitpoints -= 1
		if body.hitpoints < 0:
			body.break_sprite()
			play_destroy_sfx()
		else:
			body.animation_player.play("hit_flash")
			body.hit_block_sfx.play()
			body.create_coin()
			
			
func play_destroy_sfx():
	var sound_sfx = destroy_sfx.instantiate()
	get_parent().add_child(sound_sfx)
	sound_sfx.play()
	await sound_sfx.finished
	sound_sfx.queue_free()
