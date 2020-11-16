extends Area2D

#Váriavel para ser usada no script do inimigo para localização.
var target = null

#Detecta se o Player entra na Área de detecção. 
func can_see_player():
	return target != null

func _on_AttackDetectionZone_body_entered(body):
	target = body

func _on_AttackDetectionZone_body_exited(body):
	target = null
