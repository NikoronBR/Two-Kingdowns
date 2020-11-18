extends KinematicBody2D


#Cria variável para caminho a ser seguido.
onready var path_follow = get_parent()

#Define a velocidade da serra.
var velocidade = 150

func _physics_process(delta):
	MovementLoop(delta)

#Função que define como será o movimento do personagem.
func MovementLoop(delta):
	path_follow.set_offset(path_follow.get_offset() + velocidade * delta)
	var pos = path_follow.get_global_position()
	
