extends Control

#faz com que o menu de morte fique escondido
func _ready():
	set_process(false)
	hide()
	
#Quando o player morre mostra o menu e ativa o "process" do node	
func _on_Player_player_morto(_global_position):
	show()
	set_process(true)

#Checa se a ação "ui_select" (atualmente condiz ao espaço) foi ativado,
#então repõe a vida do player e recarrega a cena.
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_select"):
		PlayerStats.health = PlayerStats.max_health
		get_tree().reload_current_scene()
