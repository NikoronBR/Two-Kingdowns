extends Node

#varíaveis de vida
export(int) var max_health = 1 setget set_max_health
var health = max_health setget set_health

signal no_health
signal health_changed(value)
signal max_health_changed(value)

#função ativada quando a vida MÁXIMA mudar
func set_max_health(value):
	#aplica a mudança para a vida MÁXIMA do elemento
	max_health = value
	self.health = min(health, max_health)
	#sinal emitido para a HUD
	emit_signal("max_health_changed", max_health)

#função ativada quando a vida mudar
func set_health(value):
	#aplica a mudança para a vida do elemento
	health = value
	#sinal emitido para a HUD
	emit_signal("health_changed", health)
	#sinal caso a vida chegue a 0
	if health <= 0:
		emit_signal("no_health")

#função para que a vida do elemento seja a da vida máxima no ínicio do jogo.
func _ready():
	self.health = max_health
