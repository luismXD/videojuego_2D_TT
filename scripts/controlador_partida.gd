class_name ControladorPartida

extends Node

@export var partida: DatosPartida


var _ruta_jugador: String = "user://datos_jugador.tres"

func _ready():
	cargar_partida()

func guardar_partida():
	ResourceSaver.save(partida, _ruta_jugador)
	print("Partida guardada")
	
	
func cargar_partida():
	if ResourceLoader.exists(_ruta_jugador):
		partida = ResourceLoader.load(_ruta_jugador)
	else:
		partida = DatosPartida.new()

func borrar_datos():
	partida = DatosPartida.new()
	
	if ResourceLoader.exists(_ruta_jugador):
		DirAccess.remove_absolute(_ruta_jugador)
		print("Archivo de guardado eliminado")
