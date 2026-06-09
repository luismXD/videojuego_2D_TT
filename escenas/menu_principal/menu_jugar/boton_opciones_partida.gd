extends Button



func _ready():
	if ControladorPartidaGlobal.partida.jugador["nombre"].is_empty():
		disabled = true
	else:
		disabled = false
		pressed.connect(_menu_usuario)
	

func _menu_usuario():
	get_tree().change_scene_to_file("res://escenas/menu_principal/opciones_usuario/menu_opciones_usuario.tscn")
