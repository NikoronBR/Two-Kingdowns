extends Area2D

onready var animatedSprite = $AnimatedSprite

var speed = 80
var velocity = Vector2()

# Varíaveis necessárias para lançar o projétil, preenchidas no script do lançador
func start(_position, _direction):
	position = _position
	velocity = _direction * speed
	
# Para atualizar a posição do projétil e fazer sua animação
func _process(delta):
	position += velocity * delta
	animatedSprite.play("spell")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Spell_body_entered(body):
	queue_free()

func _on_Spell_area_entered(area):
	queue_free()

	
