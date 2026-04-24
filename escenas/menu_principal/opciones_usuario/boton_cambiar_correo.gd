extends Button

@export var popup_layer: CanvasLayer
@export var popup_mensajes_error: CanvasLayer

@export var ventana_popup: PanelContainer
@export var ventana_error_correo: PanelContainer

@export var email_input: LineEdit

#@export var boton_nueva_partida: Button  # Nuevo export
@export var boton_aceptar_correo: Button      
@export var boton_regresar:Button
@export var boton_aceptar_error: Button
#@export var boton_aceptar_error_general: Button

@export var subviewport_container: SubViewportContainer
#@export var subviewport: SubViewport
#if subviewport:
	#subviewport.gui_disable_input = true


func _ready():

	pressed.connect(_on_boton_camiar_correo_pressed)


	if popup_mensajes_error:
		popup_mensajes_error.hide()

	if popup_layer:
		popup_layer.hide()
	
	if subviewport_container:
		subviewport_container.mouse_filter = Control.MOUSE_FILTER_IGNORE

	if boton_aceptar_correo:
		boton_aceptar_correo.pressed.connect(_on_boton_aceptar_correo_pressed)
	if boton_regresar:
		boton_regresar.pressed.connect(_on_boton_regresar_pressed)
	if boton_aceptar_error:
		boton_aceptar_error.pressed.connect(_on_boton_aceptar_error)

func _on_boton_camiar_correo_pressed():
	if popup_layer:
		popup_layer.show()
		print("Popup mostrado")
	if subviewport_container:
		subviewport_container.mouse_filter = Control.MOUSE_FILTER_STOP



func mostrar_error(tipo: String):
	if popup_mensajes_error:
		popup_mensajes_error.show()

	# Ocultamos todos primero
	if ventana_error_correo:
		ventana_error_correo.hide()

	# Mostramos el que corresponde
	if tipo == "correo":
		ventana_error_correo.show()


func _on_boton_aceptar_correo_pressed():
	var email = email_input.text
	
	if email == "":
		mostrar_error("correo")
		return
	

	print("Comenzando juego con:", email)
	

	ControladorPartidaGlobal.partida.jugador["correo_electronico"] = email
	
	ControladorPartidaGlobal.guardar_partida()
	
	print("correo: ", ControladorPartidaGlobal.partida.jugador["correo_electronico"])
	
	popup_layer.hide()

	if subviewport_container:
		subviewport_container.mouse_filter = Control.MOUSE_FILTER_IGNORE


func _on_boton_regresar_pressed():
	popup_layer.hide()
	if subviewport_container:
		subviewport_container.mouse_filter = Control.MOUSE_FILTER_IGNORE




func _on_boton_aceptar_error():
	popup_mensajes_error.hide()


#
#func _cambiar_escena(escena: bool):
	##controlador_partida.borrar_partida()
	#if escena == true:
		#get_tree().change_scene_to_file("res://escenas/mundo_abierto/escenario_principal/escenario_principal.tscn")
