extends KinematicBody2D

export var VELOCIDADE_MAX = 100
export var ACELERACAO = 600
export var FREIO = 600

enum {
	ANDAR,
	ATACAR
}

#GustavoEsteveAqui

var velocidade = Vector2.ZERO
var state = ANDAR

#onready var animationPlayer = $AnimationPlayer
#onready var animationTree = $AnimationTree
#onready var animationState = animationTree.get("parameters/playback")
#onready var hurtbox = $Hurtbox

func _physics_process(delta):
	match state:
		ANDAR:
			andar_state(delta)
		
		#ATACAR:
			#atacar_state()
			
func andar_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		#animationTree.set("parameters/Idle/blend_position", input_vector)
		#animationTree.set("parameters/Run/blend_position", input_vector)
		#animationTree.set("parameters/Attack/blend_position", input_vector)
		#animationState.travel("Run")
		velocidade = velocidade.move_toward(input_vector * VELOCIDADE_MAX, ACELERACAO * delta)
		
	else:
		#animationState.travel("Idle")
		velocidade = velocidade.move_toward(Vector2.ZERO, FREIO * delta)
		
	move()
	
	#if Input.is_action_just_pressed("ataque"):
		#state = ATACAR

#func atacar_state():
	#velocidade = Vector2.ZERO
	#animationState.travel("Attack")

func move():
	velocidade = move_and_slide(velocidade)

#func atacar_fim():
	#state = ANDAR

#func _on_Hurtbox_area_entered(_area):
	#stats.health -= 1
	#hurtbox.start_invincibility(1.0)
	#hurtbox.create_hit_effect()
