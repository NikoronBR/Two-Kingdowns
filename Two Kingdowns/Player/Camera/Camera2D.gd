extends Camera2D

const SCREEN_SIZE = Vector2(160,128)
const HUD_THICKNESS =  16
var grid_pos = Vector2(0,0)

func _process(delta):
	var player_grid_pos = get_grid_pos(get_node("../Player").global_position)
	global_position = lerp(global_position, player_grid_pos * SCREEN_SIZE, 0.08)
	grid_pos = player_grid_pos

func get_grid_pos(pos):
	pos.y -= HUD_THICKNESS
	var x = floor(pos.x / SCREEN_SIZE.x)
	var y = floor(pos.y / SCREEN_SIZE.y)
	return Vector2(x,y)



"""const SCREEN_SIZE = Vector2(160,128)

func _process(delta):
	var pos = get_node("../Player").global_position - Vector2(0,16)
	global_position = lerp(global_position, pos * SCREEN_SIZE, 0.08)
	var x = floor(pos.x / 160) * 160
	var y = floor(pos.y / 144) * 144
	global_position = Vector2(x,y)

func _on_Player_player_morto(global_position):
	global_position = global_position
	set_process(false)
"""
