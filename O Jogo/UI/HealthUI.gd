extends Control

var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts

onready var heartEmpty = $HeartEmpty
onready var heartFull = $HeartFull

#ativada quando o sinal de vida do stats é enviado e recebido pelo setget
func set_hearts(value):
	#Sincroniza a quantidade de corações com a vida do jogador. O 'clamp' garante que
	#o valor seja maior que zero e menor que o numero máximo de corações.
	hearts = clamp(value, 0, max_hearts)
	if heartFull != null:
		heartFull.rect_size.x = hearts * 21
	
#ativada quando o sinal de vida MÁXIMA do stats é enviado e recebido pelo setget
func set_max_hearts(value):
	#Sincronização e 'Max' garante que a vida máxima seja maior que 1.
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heartEmpty != null:
		heartEmpty.rect_size.x = max_hearts * 21
	
#função para adequar a HUD com a Vida do jogador e conectar os sinais de ''Stats''. 
func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.connect("health_changed", self, "set_hearts")
	PlayerStats.connect("max_health_changed", self, "set_max_hearts")

