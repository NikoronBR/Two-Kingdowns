extends KinematicBody2D

#Configurando valores de velocidade máxima, aceleração e friccção do personagem.
export var MAX_SPEED = 100
export var ACCELERATION = 600
export var FRICTION = 600

#Definindo constantes para as ações do personagem.
enum {
	MOVE,
	ATTACK
}

#Definindo variáveis para velocidade e estado do personagem.
var velocity = Vector2.ZERO
var state = MOVE

#Definindo variaveis para a animação.
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitobox = $SwordHitbox

#Função para ativar elementos ao abrir o jogo.
func _ready():
	#Ativar árvore de animação.
	animationTree.active = true
	#Ativar direção inicial para o knockback.
	swordHitobox.knockback_vector = Vector2.LEFT

func _physics_process(delta):
	#Definido a animação e ações do personagem baseados nos inputs
	match state:
		MOVE:
			move_state(delta)
		
		#ATTACK:
			#attack_state()
			
func move_state(delta):
	#Ligando inputs do teclado a direções que o jogador irá se movimentar. 
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		swordHitobox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		#animationTree.set("parameters/Run/blend_position", input_vector)
		#animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Idle")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move()
	
	#if Input.is_action_just_pressed("atacar"):
		#state = ATTACK

#func attack_state():
	#velocity = Vector2.ZERO
	#animationState.travel("Attack")

func move():
	velocity = move_and_slide(velocity)

#func atacck_end():
	#state = MOVE

#func _on_Hurtbox_area_entered(_area):
	#stats.health -= 1
	#hurtbox.start_invincibility(1.0)
	#hurtbox.create_hit_effect()


