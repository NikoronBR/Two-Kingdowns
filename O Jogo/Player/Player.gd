extends KinematicBody2D

export var MAX_SPEED = 100
export var ACCELERATION = 600
export var FRICTION = 600

enum {
	MOVE,
	ATTACK
}

#GustavoEsteveAqui

var velocity = Vector2.ZERO
var state = MOVE

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
#onready var hurtbox = $Hurtbox

func _ready():
	animationTree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		
		#ATTACK:
			#attack_state()
			
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		#animationTree.set("parameters/Run/blend_position", input_vector)
		#animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Idle")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move()
	
	#if Input.is_action_just_pressed("ataque"):
		#state = ATTACK

#func attack_state():
	#velocity = Vector2.ZERO
	#animationState.travel("Attack")

func move():
	velocity = move_and_slide(velocity)

#func atacck_fim():
	#state = MOVE

#func _on_Hurtbox_area_entered(_area):
	#stats.health -= 1
	#hurtbox.start_invincibility(1.0)
	#hurtbox.create_hit_effect()
