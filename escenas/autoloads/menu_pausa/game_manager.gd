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

var menu_abierto := false
var valor_sonido = 0
func toggle_menu():
	menu_abierto = !menu_abierto  # ← esto invierte el estado
	#print(menu_abierto)
	menu_toggled.emit(menu_abierto)
	get_tree().paused = menu_abierto

func set_volumen(valor: float):
	volumen_cambiado.emit(valor)


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
