extends KinematicBody2D

var Spell = preload("res://Enemies/Projetil/Spell.tscn")
var knockback = Vector2.ZERO

onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var Cooldown = $Cooldown

signal shoot

func _physics_process(delta):
# Cria uma fricção para o inimigo resistir ao knockback
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

# Para lançar projetil
	if playerDetectionZone.can_see_player():
		if Cooldown.is_stopped():
			var player = playerDetectionZone.player
			var direction_ = global_position.direction_to(player.global_position)
			var position_ = global_position
			emit_signal('shoot', Spell, position_, direction_)
			Cooldown.start()

# Quando detecta um Ataque diminui a vida e aplica a direção e velocidade do knockback
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 100
	
# Faz o inimigo desaparecer quando acaba a vida.
func _on_Stats_no_health():
	queue_free()
