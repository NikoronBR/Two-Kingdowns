extends CanvasLayer

func _process(delta):
	$qtdchaves.frame = get_node("../YSort/Player").chaves
