extends CanvasLayer

func _process(delta):
	$qtdchaves.frame = PlayerStats.chaves

func _on_Player_player_morto(global_position):
	set_process(false)
