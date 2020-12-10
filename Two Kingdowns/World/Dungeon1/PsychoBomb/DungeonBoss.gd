extends Node2D

#Coloca o node de transição em uma variavel
onready var _transition_rect := $HUD/SceneTransitionRect
onready var deathMenu = $HUD/DeathMenu

func _ready():
	set_process_unhandled_key_input(false)
	
func on_player_morto(global_position):
	set_process_unhandled_key_input(true)
	deathMenu.show()

#Função para criar projétil no mundo.
func _on_Projectile_shoot(Projectile, _position, _direction):
	var projectile = Projectile.instance()
	add_child(projectile)
	projectile.start(_position, _direction)

#recarregar cena
func _unhandled_key_input(event):
	if event.is_pressed():
		PlayerStats.health = PlayerStats.max_health
		get_tree().reload_current_scene()

#Usa a função do node de transição para mudar de cena com fade
func mudar_cena():
	_transition_rect.transition_to()
