extends Area2D

onready var animatedSprite = $AnimatedSprite

var speed = 80
var velocity = Vector2()

func start(_position, _direction):
	position = _position
	velocity = _direction * speed
	
func _process(delta):
	position += velocity * delta
	animatedSprite.play("spell")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Spell_body_entered(body):
	queue_free()

func _on_Spell_area_entered(area):
	queue_free()

	
