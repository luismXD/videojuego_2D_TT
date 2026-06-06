#extends Node
#
#signal menu_toggled(visible: bool)
#
#var menu_abierto := false
#
#func toggle_menu():
	#menu_abierto = !menu_abierto
	#menu_toggled.emit(menu_abierto)
	## Pausa el juego mientras el menú está abierto
	#get_tree().paused = menu_abierto

extends Node

signal menu_toggled(visible: bool)
signal volumen_cambiado(valor: float)
signal jugador_en_rango
signal jugador_salio_de_rango
signal ocultar_dialogo_signal
signal guardar_posicion_signal

var menu_abierto := false
var valor_sonido = 0
func toggle_menu():
	menu_abierto = !menu_abierto  # ← esto invierte el estado
	#print(menu_abierto)
	menu_toggled.emit(menu_abierto)
	get_tree().paused = menu_abierto

func ocultar_dialogo():
	ocultar_dialogo_signal.emit()


func set_volumen(valor: float):
	volumen_cambiado.emit(valor)

func jugador_interaction_en_rango():
	jugador_en_rango.emit()

func jugador_interaction_fuera_rango():
	jugador_salio_de_rango.emit()

func guardar_posicion():
	guardar_posicion_signal.emit()

#func guardar_posicion():
	#ControladorPartidaGlobal.partida.jugador["posicion"] = parent.global_position
	#ControladorPartidaGlobal.guardar_partida()

#func toggle_menu():
	#guardar_posicion()
	#GameManager.toggle_menu()


#
#func cerrar_menu():
	#menu_abierto = false
	#menu_toggled.emit(menu_abierto)
	#get_tree().paused = false
#
#func abrir_menu():
	#menu_abierto = true
	#menu_toggled.emit(menu_abierto)
	#get_tree().paused = true
