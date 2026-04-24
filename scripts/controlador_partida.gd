class_name ControladorPartida

extends Node

@export var partida: DatosPartida

var _ruta_jugador: String = "user://datos_jugador.tres"

func _ready():
	cargar_partida()
	#if partida == null:
		#partida = DatosPartida.new()

#func guardar_partida():
	#var guardar_partida = partida.jugador
	#ResourceSaver.save(guardar_partida, _ruta_jugador)
func guardar_partida():
	ResourceSaver.save(partida, _ruta_jugador)
	print("Partida guardada")
	
	
func cargar_partida():
	if ResourceLoader.exists(_ruta_jugador):
		partida = ResourceLoader.load(_ruta_jugador)
	else:
		partida = DatosPartida.new()
		#print("Datos cargados")
		#print(partida.jugador["nombre"])
		#print(partida.jugador["correo_electronico"])
		#print(partida.jugador["analisis"])
func borrar_datos():
	partida = DatosPartida.new()
	
	if ResourceLoader.exists(_ruta_jugador):
		DirAccess.remove_absolute(_ruta_jugador)
		print("Archivo de guardado eliminado")


#func deteccion_emocional():
	#
#func cargar_partida():
	#if ResourceLoader.exists(_ruta):
		#partida = load(_ruta)
		#ContadorVictoriasGlobal.wins = partida.wins
		#
		#ContadorVictoriasGlobal.win_update.emit("X", partida.wins["X"])
		#ContadorVictoriasGlobal.win_update.emit("O", partida.wins["O"])
#
#func borrar_partida():
	#partida.wins["X"] = 0
	#partida.wins["O"] = 0
	#
	#ContadorVictoriasGlobal.wins["X"] = 0
	#ContadorVictoriasGlobal.wins["O"] = 0
	#
	#ResourceSaver.save(partida, _ruta)
	#
	## Forzar actualización del UI
	#ContadorVictoriasGlobal.win_update.emit("X", 0)
	#ContadorVictoriasGlobal.win_update.emit("O", 0)
