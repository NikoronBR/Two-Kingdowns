extends Area2D

#Váriavel para ser usada no script do inimigo para localização.
var player = null

#Detecta se o Player entra na Área de detecção. 
func can_see_player():
	return player != null

func _on_PlayerDetectionZone_body_entered(body):
	player = body

func _on_PlayerDetectionZone_body_exited(body):
	player = null
	
