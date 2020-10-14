extends TextureButton

func _ready():
	pass


func _on_NovoJogo_pressed():
	get_tree().change_scene("res://World/Bioma_Padrao/World.tscn")


func _on_Sair_pressed():
	get_tree().quit()
	pass
