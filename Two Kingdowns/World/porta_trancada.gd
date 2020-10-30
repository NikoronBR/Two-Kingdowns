extends StaticBody2D

func _ready():
	$area.connect("body_entered",self,"body_entered")
	
func body_entered(body):
	if body.name == "Player" and PlayerStats.chaves > 0:
		PlayerStats.chaves -= 1
		queue_free()



