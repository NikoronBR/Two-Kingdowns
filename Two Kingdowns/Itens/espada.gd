extends Area2D

func _ready():
	#Conecta o sinal do corpo sendo entrado com a função body_entered
	PlayerStats.espada = false
	connect("body_entered",self,"body_entered")
	
func body_entered(body):
	#Se o jogador encostar em uma espada irá pegá-la.
	PlayerStats.espada = true
	queue_free()

