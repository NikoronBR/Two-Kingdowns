extends Node2D

func _on_Spell_shoot(Spell, _position, _direction):
	var spell = Spell.instance()
	add_child(spell)
	spell.start(_position, _direction)
