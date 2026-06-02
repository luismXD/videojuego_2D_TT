extends Button

func _ready():
	if ControladorPartidaGlobal.partida.jugador["nombre"].is_empty():
		disabled = true
	else:
		disabled = false
		pressed.connect(_jugar)

func _jugar():
	
	ControladorPartidaGlobal.cargar_partida()

	get_tree().change_scene_to_file("res://main.tscn")
