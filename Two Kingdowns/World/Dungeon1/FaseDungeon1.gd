extends Node2D

#Função para criar projétil no mundo.
func _on_Projectile_shoot(Projectile, _position, _direction):
	var projectile = Projectile.instance()
	add_child(projectile)
	projectile.start(_position, _direction)
