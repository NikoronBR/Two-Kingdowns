extends Camera2D

#Define o tamanho da tela.
const SCREEN_SIZE = Vector2(160,144)

func _process(delta):
	#Define a posição do jogador.
	var player_grid_pos = get_grid_pos(get_node("../Player").global_position)
	#Faz com que a câmera transite de áreas gradualmente
	global_position = lerp(global_position, player_grid_pos * SCREEN_SIZE, 0.08)

#Calcula a posição do objeto relativa ao tamanho da tela (área da câmera).
func get_grid_pos(pos):
	var x = floor(pos.x / SCREEN_SIZE.x)
	var y = floor(pos.y / SCREEN_SIZE.y)
	return Vector2(x,y)

# Faz com que a câmera fique na posição de morte do player.
func _on_Player_player_morto(global_position):
	global_position = global_position
	set_process(false)

