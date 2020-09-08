extends KinematicBody2D

var FantasmaDeathEffect = preload("res://Effects/FantasmaDeathEffect.tscn")

export var ACCELERATION = 385
export var MAX_SPEED = 50
export var FRICTION = 185
export var WANDER_TARGET_RANGE = 4

enum {
	IDLE,
	WANDER,
	CHASE
}

var state = CHASE
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftColision
onready var wanderController = $WanderController

func _ready():
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
# Cria uma fricção para o inimigo resistir ao knockback
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)

	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			
			#chama o 'update_wander' quando intervalo acaba
			if wanderController.get_time_left() == 0:
				update_wander()
				
		WANDER:
			seek_player()
			
			#move o inimigo na posição alvo gerada no WanderController
			accelerate_towards_point(wanderController.target_position, delta)
			
			#If's que chama o update quando o intervalo acaba ou o inimigo chega na posição.
			if wanderController.get_time_left() == 0:
				update_wander()
		
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
				
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE
			
	
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)

#função que pega um vetor e faz o inimigo se mover até ele.
func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

#função para anternar entre states IDLE e WANDER aleatóriamente e reniciar
#o intervalo do WanderController.
func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))

#função para gerar váriavel IDLE e WANDER de forma aleatória
func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

# Quando detecta um Ataque diminui a vida e aplica a direção e velocidade do knockback
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 170
	hurtbox.create_hit_effect()
	
# Faz o inimigo desaparecer quando acaba a vida.
func _on_Stats_no_health():
	queue_free()
	var fantasmaDeathEffect = FantasmaDeathEffect.instance()
	get_parent().add_child(fantasmaDeathEffect)
	fantasmaDeathEffect.global_position = global_position
