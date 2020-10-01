extends Camera2D


func _process(delta):
	var pos = get_node("../Player").global_position - Vector2(0,16)
	var x = floor(pos.x / 160) * 160
	var y = floor(pos.y / 144) * 144
	global_position = Vector2(x,y)

func _on_Player_player_morto(global_position):
	global_position = global_position
	set_process(false)
