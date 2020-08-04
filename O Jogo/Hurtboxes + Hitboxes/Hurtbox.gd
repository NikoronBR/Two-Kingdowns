extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position
	
	
	
	
	
	
	
