extends Button

@export var popup_layer: CanvasLayer
@export var popup_mensajes_error: CanvasLayer

@export var ventana_popup: PanelContainer
@export var ventana_error_nombre: PanelContainer
@export var ventana_error_correo: PanelContainer
@export var ventana_error_general: PanelContainer

@export var nombre_input: LineEdit
@export var email_input: LineEdit

#@export var boton_nueva_partida: Button  # Nuevo export
@export var boton_comenzar: Button      
@export var boton_regresar:Button
@export var boton_aceptar_nombre: Button
@export var boton_aceptar_correo: Button
@export var boton_aceptar_error_general: Button


@export var icon_izq: TextureRect
@export var icon_der: TextureRect


func _ready():

	pressed.connect(_on_boton_nueva_partida_pressed)
	


	if popup_mensajes_error:
		popup_mensajes_error.hide()

	if popup_layer:
		popup_layer.hide()
	
	if boton_comenzar:
		boton_comenzar.pressed.connect(_on_boton_comenzar_pressed)
	if boton_regresar:
		boton_regresar.pressed.connect(_on_boton_regresar_pressed)
	if boton_aceptar_nombre:
		boton_aceptar_nombre.pressed.connect(_on_boton_aceptar_nombre_y_correo)
		boton_aceptar_correo.pressed.connect(_on_boton_aceptar_nombre_y_correo)
		boton_aceptar_error_general.pressed.connect(_on_boton_aceptar_nombre_y_correo)

func _on_boton_nueva_partida_pressed():
	if popup_layer:
		popup_layer.show()
		print("Popup mostrado")

func mostrar_error(tipo: String):
	if popup_mensajes_error:
		popup_mensajes_error.show()

	# Ocultamos todos primero
	if ventana_error_nombre:
		ventana_error_nombre.hide()
	if ventana_error_correo:
		ventana_error_correo.hide()
	if ventana_error_general:
		ventana_error_general.hide()

	# Mostramos el que corresponde
	if tipo == "nombre":
		ventana_error_nombre.show()
	elif tipo == "correo":
		ventana_error_correo.show()
	elif tipo == "general":
		ventana_error_general.show()


func _on_boton_comenzar_pressed():
	var nombre = nombre_input.text
	var email = email_input.text
	
	if nombre == "" and email == "":
		mostrar_error("general")
		return
	if nombre == "":
		mostrar_error("nombre")
		return
	
	if email == "":
		mostrar_error("correo")
		return
	

	print("Comenzando juego con:", nombre,",", email)
	
	ControladorPartidaGlobal.partida.jugador["nombre"] = nombre
	ControladorPartidaGlobal.partida.jugador["correo_electronico"] = email
	
	ControladorPartidaGlobal.guardar_partida()
	
	print("nombre: ", ControladorPartidaGlobal.partida.jugador["nombre"], "correo: ", ControladorPartidaGlobal.partida.jugador["correo_electronico"])
	
	popup_layer.hide()
	_cambiar_escena(true)
	
func _on_boton_regresar_pressed():
	popup_layer.hide()

func _on_boton_aceptar_nombre_y_correo():
	popup_mensajes_error.hide()
	#popup_mensajes_error.hide()


func _cambiar_escena(escena: bool):
	#controlador_partida.borrar_partida()
	if escena == true:
		get_tree().change_scene_to_file("res://main.tscn")
