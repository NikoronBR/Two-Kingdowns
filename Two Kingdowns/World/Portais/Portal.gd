extends Area2D


signal portal_adentrado()
onready var root_node = get_tree().get_current_scene()

func _ready():
	#Conecta o sinal do corpo sendo entrado com a função body_entered
	connect("body_entered",self,"body_entered")
	#conecta o sinal "mudar_cena", com "mudar_cena" do node principal.
	connect("portal_adentrado", root_node, "mudar_cena")

func body_entered(body):
	emit_signal("portal_adentrado")
	


