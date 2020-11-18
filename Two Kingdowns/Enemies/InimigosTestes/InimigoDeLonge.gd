extends KinematicBody2D

# Carregando a cena do Spell no script.
var FantasmaDeathEffect = preload("res://Effects/FantasmaDeathEffect.tscn")
var Spell = preload("res://Enemies/Projetil/Spell.tscn")
var knockback = Vector2.ZERO

onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var Cooldown = $Cooldown
onready var hurtbox = $Hurtbox

signal shoot

func _ready():
	set_physics_process(false)

func _physics_process(delta):
# Cria uma fricção para o inimigo resistir ao knockback
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

# Para lançar projetil
	if playerDetectionZone.can_see_player():
		if Cooldown.is_stopped():
			#Varíaveis para posição do player e do lançador
			var player = playerDetectionZone.player
			var direction_ = global_position.direction_to(player.global_position)
			var position_ = global_position
			sprite.flip_h = direction_.x < 0
			#Sinal com varíaveis enviadas para o node "World"
			emit_signal('shoot', Spell, position_, direction_)
			Cooldown.start()

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 170
	hurtbox.create_hit_effect()
	
func _on_Stats_no_health():
	queue_free()
	var fantasmaDeathEffect = FantasmaDeathEffect.instance()
	get_parent().add_child(fantasmaDeathEffect)
	fantasmaDeathEffect.global_position = global_position
