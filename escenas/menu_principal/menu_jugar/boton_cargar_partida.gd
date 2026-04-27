extends Button

@export var icon_izq: TextureRect
@export var icon_der: TextureRect

func _ready():
	
	pressed.connect(_jugar)
	


func _jugar():
	var correo_electronico =  ControladorPartidaGlobal.partida.jugador["correo_electronico"]
	var nombre = ControladorPartidaGlobal.partida.jugador["nombre"]
	ControladorPartidaGlobal.cargar_partida()

	_cambiar_escena(true)
	print("nombre: ", nombre, ", correo:", correo_electronico)
	
func _cambiar_escena(escena: bool):
	#controlador_partida.borrar_partida()
	if escena == true:
		get_tree().change_scene_to_file("res://main.tscn")
