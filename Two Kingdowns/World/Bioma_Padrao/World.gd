extends Node2D

#Coloca o node de transição em uma variavel
onready var _transition_rect := $HUD/SceneTransitionRect

#Função para criar projétil no mundo.
func _on_Projectile_shoot(Projectile, _position, _direction):
	var projectile = Projectile.instance()
	add_child(projectile)
	projectile.start(_position, _direction)

#Usa a função do node de transição para mudar de cena com fade
func mudar_cena():
	_transition_rect.transition_to()
