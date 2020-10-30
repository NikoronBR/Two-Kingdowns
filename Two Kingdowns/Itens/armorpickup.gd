extends Area2D

func _ready():
	#Conecta o sinal do corpo sendo entrado com a função body_entered
	connect("body_entered",self,"body_entered")

signal pegar_armor
	
func body_entered(body):
	#Se o jogador encostar na armadura ira mandar um sinal.
	PlayerStats.armor = true
	emit_signal("pegar_armor")
	queue_free()
