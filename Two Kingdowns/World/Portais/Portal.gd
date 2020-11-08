extends Area2D


func _ready():
	#Conecta o sinal do corpo sendo entrado com a função body_entered
	connect("body_entered",self,"body_entered")


func body_entered(body):
	get_tree().change_scene("res://World/Dungeon1/FaseDungeon1.tscn")
