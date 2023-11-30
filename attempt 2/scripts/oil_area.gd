extends Area2D

@onready var collision = $collision as CollisionShape2D
@onready var oil = $oil as Sprite2D

func _ready():
	collision.shape.size = oil.get_rect().size
	


func _on_body_entered(body):
	if body.name == "player" && body.has_method("take_damage_void"):
		body.take_damage_void(Vector2(0,0))
