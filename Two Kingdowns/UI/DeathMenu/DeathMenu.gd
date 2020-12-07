extends Control

#faz com que o menu de morte fique escondido
func _ready():
	set_process_unhandled_key_input(false)
	hide()
	
#Quando o player morre mostra o menu e ativa o "process" do node	
func _on_Player_player_morto(_global_position):
	set_process_unhandled_key_input(true)
	show()

#Checa se a ação algum botão foi pressionado,
#então repõe a vida do player e recarrega a cena.
func _unhandled_key_input(event):
	if event.is_pressed():
		PlayerStats.health = PlayerStats.max_health
		get_tree().reload_current_scene()
