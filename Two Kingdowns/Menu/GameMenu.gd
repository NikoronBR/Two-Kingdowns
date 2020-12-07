extends Control

#Coloca o node de transição em uma variavel
onready var _transition_rect := $SceneTransitionRect

#Usa a função do node de transição para mudar de cena com fade
func _on_NovoJogo_pressed():
	_transition_rect.transition_to("res://World/Bioma_Padrao/World.tscn")

func _on_Sair_pressed():
	get_tree().quit()
	pass
