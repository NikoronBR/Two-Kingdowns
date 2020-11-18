extends KinematicBody2D

# Carregando a cena do Spell no script.
var Spell = preload("res://Enemies/Projetil/Spell.tscn")

onready var playerDetectionZone = $PlayerDetectionZone
onready var Cooldown = $Cooldown

signal shoot

func _ready():
	set_physics_process(false)

func _physics_process(delta):
# Para lançar projetil
	if playerDetectionZone.can_see_player():
		if Cooldown.is_stopped():
			#Varíaveis para posição do player e do lançador
			var player = playerDetectionZone.player
			var direction_ = global_position.direction_to(player.global_position)
			var position_ = global_position
			#Sinal com varíaveis enviadas para o node "World"
			emit_signal('shoot', Spell, position_, direction_)
			Cooldown.start()
