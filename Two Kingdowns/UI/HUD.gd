extends CanvasLayer

func _process(delta):
	$qtdchaves.frame = get_node("../YSort/Player").chaves

func _on_Player_player_morto(global_position):
	set_process(false)
