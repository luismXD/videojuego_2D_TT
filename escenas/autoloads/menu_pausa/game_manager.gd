extends Node

signal menu_toggled(visible: bool)

var menu_abierto := false

func toggle_menu():
	menu_abierto = !menu_abierto
	menu_toggled.emit(menu_abierto)
	# Pausa el juego mientras el menú está abierto
	get_tree().paused = menu_abierto
