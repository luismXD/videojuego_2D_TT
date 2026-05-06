extends CanvasLayer

@export var boton_salir:Button
@export var boton_reanudar:Button
@export var boton_opciones:Button
@export var boton_ventana:Button

#boton opciones
@export var popup_opciones: CanvasLayer
@export var ventana_popup_sonido: PanelContainer


@export var barra_sonido_ajuste: HSlider
@export var progress_bar_sonido: ProgressBar
@export var boton_opciones_regresar:Button

#@export var boton_aceptar_error: Button

func _ready() -> void:
	# Pone todos los hijos en modo When Paused automáticamente
	_set_process_mode_recursive(self, Node.PROCESS_MODE_WHEN_PAUSED)

	GameManager.menu_toggled.connect(_on_menu_toggled)
	visible = false

	if popup_opciones:
		_set_process_mode_recursive(popup_opciones, Node.PROCESS_MODE_WHEN_PAUSED)
		popup_opciones.hide()

	if boton_reanudar:
		boton_reanudar.pressed.connect(_on_reanudar_pressed)
	if boton_salir:
		boton_salir.pressed.connect(salir_a_menu)
	if boton_opciones:
		boton_opciones.pressed.connect(on_opciones_pressed)
	if boton_opciones_regresar:
		boton_opciones_regresar.pressed.connect(on_opciones_regresar_presssed)
	#if boton_ventana:
		#boton
	
	#if ControladorPartidaGlobal.partida:  # Verifica que exista
	barra_sonido_ajuste.value = ControladorPartidaGlobal.partida.jugador["volumen"]
	progress_bar_sonido.value = barra_sonido_ajuste.value
	if barra_sonido_ajuste:
		barra_sonido_ajuste.value_changed.connect(_on_barra_sonido_ajuste_value_changed)



func _set_process_mode_recursive(node: Node, mode: int) -> void:
	node.process_mode = mode
	#print("Process mode set: ", node.name)  # ← temporal para debuggear
	for child in node.get_children():
		_set_process_mode_recursive(child, mode)

func _on_menu_toggled(abierto: bool) -> void:
	visible = abierto
	popup_opciones.hide()


func _on_reanudar_pressed() -> void:
	on_opciones_regresar_presssed()
	GameManager.toggle_menu()



func salir_a_menu():
	#controlador_partida.borrar_partida()
	GameManager.toggle_menu()
	get_tree().change_scene_to_file("res://escenas/menu_principal/menu_jugar/escena_menu_jugar.tscn")

func on_opciones_pressed():
	if popup_opciones:
		popup_opciones.show()

func on_opciones_regresar_presssed():
	#print("salir presionado")
	if popup_opciones:
		popup_opciones.hide()
	

	#print("valor guardado: ", ControladorPartidaGlobal.partida.jugador["volumen"])

func _on_barra_sonido_ajuste_value_changed(value: float) -> void:
	print("Valor de la barra de sonido: ", value + 100)
	progress_bar_sonido.value = value
	ControladorPartidaGlobal.partida.jugador["volumen"] = value
	ControladorPartidaGlobal.guardar_partida()
	barra_sonido(value)

func barra_sonido(valor: float):
	GameManager.set_volumen(valor)
#
#
	#ControladorPartidaGlobal.partida.jugador["nombre"] = nombre
	#ControladorPartidaGlobal.partida.jugador["correo_electronico"] = email
	#
	#ControladorPartidaGlobal.guardar_partida()
	#
	#print("nombre: ", ControladorPartidaGlobal.partida.jugador["nombre"], " correo: ", ControladorPartidaGlobal.partida.jugador["correo_electronico"])
	#
