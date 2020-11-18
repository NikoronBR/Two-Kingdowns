extends KinematicBody2D


export var ACCELERATION = 300
export var MAX_SPEED = 30
export var FRICTION = 180
export var CHASE_TIME = 15
export var DEFECT_TIME = 8

enum {
	DEFECT,
	CHASE,
}

var state = CHASE
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

onready var cooldownTime = $CooldownTime
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var playerDetectionZone = $PlayerDetectionZone
onready var attackDetectionZone = $AttackDetectionZone
onready var stats = $Stats
onready var hurtbox = $Hurtbox
onready var hitbox = $Hitbox

func _ready():
	animationTree.active = true
	cooldownTime.start(CHASE_TIME)
	
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

	match state:
		DEFECT:
			animationState.travel("Defect")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			update_state(CHASE_TIME, CHASE)
			
		CHASE:
			animationState.travel("Chase")
			var target = attackDetectionZone.target
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			if target != null:
				animationState.travel("Attack 2")
			update_state(DEFECT_TIME, DEFECT)
				
	velocity = move_and_slide(velocity)

#função que pega um vetor e faz o inimigo se mover até ele.
func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

# Usada para reniciar o relógio e mudar o state do boss.
func update_state(time, new_state):
	if cooldownTime.is_stopped():
		cooldownTime.start(time)
		state = new_state
	
func _on_Stats_no_health():
	queue_free()

func _on_Hurtbox_area_entered(area):
	if state == DEFECT:
		stats.health -= area.damage
		knockback = area.knockback_vector * 220
		hurtbox.create_hit_effect()
		MAX_SPEED += 10
		cooldownTime.stop()
		update_state(CHASE_TIME, CHASE)

