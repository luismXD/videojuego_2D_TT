extends CanvasLayer

#@export var boton_salir:Button
#@export var boton_reanudar:Button
#@export var boton_aceptar_error: Button

func _ready() -> void:
	ready
	## Pone todos los hijos en modo When Paused automáticamente
	#_set_process_mode_recursive(self, Node.PROCESS_MODE_WHEN_PAUSED)
	#GameManager.menu_toggled.connect(_on_menu_toggled)
	#visible = false
	#
	##if boton_reanudar:
		##boton_reanudar.pressed.connect(_on_reanudar_pressed)
	#if boton_salir:
		#boton_salir.pressed.connect(salir_a_menu)
	#
#
#func _set_process_mode_recursive(node: Node, mode: int) -> void:
	#node.process_mode = mode
	#for child in node.get_children():
		#_set_process_mode_recursive(child, mode)
#
#func _on_menu_toggled(abierto: bool) -> void:
	#visible = abierto
#
#func _on_reanudar_pressed() -> void:
	#GameManager.toggle_menu()
#
#func salir_a_menu():
	##controlador_partida.borrar_partida()
	#GameManager.toggle_menu()
	#get_tree().change_scene_to_file("res://escenas/menu_principal/menu_jugar/escena_menu_jugar.tscn")
	#
