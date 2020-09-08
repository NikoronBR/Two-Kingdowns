extends Node2D

export(int) var wander_range = 15

#valores para posição inicial e posição alvo do inimigo
onready var start_position = global_position
onready var target_position  = global_position

onready var timer = $Timer

func _ready():
	update_target_position()

#função que gera uma posição alvo em uma certa range da posição inicial para o inimigo andar.
func update_target_position():
	var target_vector = Vector2(rand_range(-wander_range, wander_range), rand_range(-wander_range, wander_range))
	target_position = start_position + target_vector

#função de intervalo de tempo para criar posição alvos.
func _on_Timer_timeout():
	update_target_position()
	
#função que obtem o tempo do intervalo
func get_time_left():
	return timer.time_left
	
#função que renicia o tempo do intervalo
func start_wander_timer(duration):
	timer.start(duration)
