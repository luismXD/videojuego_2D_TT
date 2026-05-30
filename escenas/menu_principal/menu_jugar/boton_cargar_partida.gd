extends Button

func _ready():
	pressed.connect(_jugar)

func _jugar():
	ControladorPartidaGlobal.cargar_partida()
#	CanvasLayerPantallaCarga.mostrar()
	#CanvasLayerPantallaCarga.mostrar_y_cargar("res://main.tscn")
	get_tree().change_scene_to_file("res://main.tscn")
