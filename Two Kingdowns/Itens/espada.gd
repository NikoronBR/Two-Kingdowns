extends Area2D

func _ready():
	#Conecta o sinal do corpo sendo entrado com a função body_entered
	connect("body_entered",self,"body_entered")
	
func body_entered(body):
	#Se o jogador encostar em uma chave e não tiver o máximo, irá pegá-la
	if body.name == "Player":
		body.espada = true
		queue_free()
