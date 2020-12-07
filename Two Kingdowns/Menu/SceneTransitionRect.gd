extends ColorRect

#Caso nenhum valor seja agregado na função transition_to
#o programa pega o valor do export (se tiver sido preenchido)
export(String, FILE) var next_scene_path

onready var _anim_player := $AnimationPlayer

#Ativa a animação do fade ao contrário quando inicia a cena
func _ready():
	_anim_player.play_backwards("Fade")
	
#Pega a próxima cena, ativa animação de fade, troca de cena.
func transition_to(_next_scene = next_scene_path) -> void:
	_anim_player.play("Fade")
	yield(_anim_player, "animation_finished")
	get_tree().change_scene(_next_scene)

