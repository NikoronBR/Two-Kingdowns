extends Node

# Define varíavel de vida máxima e vida atual
export(int) var max_health = 1
onready var health = max_health setget set_health #setget para detectar mudanças na vida atual

# Definir sinal para quando a vida acabar
signal no_health

# Função para pegar o valor do setget e emitir sinal quando a vida acabar
func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")

# Explicação:

# A diminuição de vida é feita no próprio script do inimigo com um "Hitbox_entered"
#a mudança na vida é detectada pelo setget, que envia o valor para função set_health que então
#manda o sinal "no_health" para ser utilizado no script do próprio inimigo.

# Hitbox_entered > diminui vida > setget detecta > atualiza valor na função >
#set_health emite sinal quando vida acaba > sinal "no_health" contém queue_free ou outro comando.
