extends Button


@export var popup_notificacion_correo: CanvasLayer

@export var ventana_popup_envio_exito: PanelContainer
@export var ventana_popup_envio_error: PanelContainer
@export var ventana_popup_cargando: PanelContainer
@export var ventana_popup_disclaimer: PanelContainer
@export var ventana_popup_error_null: PanelContainer

@export var boton_aceptar_correo_exito: Button
@export var boton_aceptar_correo_error: Button
@export var boton_aceptar_disclaimer: Button
@export var boton_cancelar_disclaimer: Button
@export var boton_aceptar_error_null: Button

@export var subviewport_container: SubViewportContainer

@export var label_correo_exito: Label
@export var label_puntos: Label


@export var http_request: HTTPRequest


var puntos = 0
var timer_cargando: Timer



func _ready():

	if popup_notificacion_correo:
		popup_notificacion_correo.hide()
	
	if subviewport_container:
		subviewport_container.mouse_filter = Control.MOUSE_FILTER_IGNORE


	pressed.connect(_mostrar_disclaimer)
	if boton_aceptar_error_null:
		boton_aceptar_error_null.pressed.connect(_on_boton_aceptar_nombre_y_correo)
	if boton_aceptar_disclaimer:
		boton_aceptar_disclaimer.pressed.connect(_on_boton_boton_aceptar_disclaimer)
	if boton_cancelar_disclaimer:
		boton_cancelar_disclaimer.pressed.connect(_on_boton_aceptar_nombre_y_correo)
	
	http_request.request_completed.connect(_on_request_completed)

	if boton_aceptar_correo_exito:
		boton_aceptar_correo_exito.pressed.connect(_on_boton_aceptar_nombre_y_correo)
	
	if boton_aceptar_correo_exito:
		boton_aceptar_correo_error.pressed.connect(_on_boton_aceptar_nombre_y_correo)


func _mostrar_disclaimer():
	if popup_notificacion_correo:
		popup_notificacion_correo.show()
	if ControladorPartidaGlobal.partida.jugador["analisis"].is_empty():
		ventana_popup_error_null.show()
		if subviewport_container:
			subviewport_container.mouse_filter = Control.MOUSE_FILTER_STOP

	else:
		ventana_popup_error_null.hide()
		ventana_popup_disclaimer.show()
		label_correo_exito.text = "EL   REPORTE   EMOCIONAL   CONTIENE   INFORMACION\nPERSONAL   SE   ENVIARA   AL   CORREO\n" + ControladorPartidaGlobal.partida.jugador["correo_electronico"]
		if subviewport_container:
			subviewport_container.mouse_filter = Control.MOUSE_FILTER_STOP
		#if popup_notificacion_correo:
			#popup_notificacion_correo.show()
		ventana_popup_cargando.hide()
		ventana_popup_envio_exito.hide()
		ventana_popup_envio_error.hide()

func _on_boton_boton_aceptar_disclaimer():
	_on_boton_generar_reporte_pressed()

func _on_boton_generar_reporte_pressed():
	_iniciar_animacion_cargando()
	if subviewport_container:
		subviewport_container.mouse_filter = Control.MOUSE_FILTER_STOP

	var correo = ControladorPartidaGlobal.partida.jugador["correo_electronico"]
	var analisis = ControladorPartidaGlobal.partida.jugador["analisis"]
	var datos = {
		"email": correo,
		"analisis": analisis
	}
	var json = JSON.stringify(datos)
	var headers = ["Content-Type: application/json"]
	http_request.request(
			"https://merry-adaptation-production-274e.up.railway.app/generar-reporte/",
			headers,
			HTTPClient.METHOD_POST,
			json
		)


func _on_boton_aceptar_nombre_y_correo():
	popup_notificacion_correo.hide()
	if subviewport_container:
		subviewport_container.mouse_filter = Control.MOUSE_FILTER_IGNORE


#Animacion de carga
func _iniciar_animacion_cargando():
	ventana_popup_disclaimer.hide()
	ventana_popup_cargando.show()
	
	if popup_notificacion_correo:
		popup_notificacion_correo.show()
	ventana_popup_envio_exito.hide()
	ventana_popup_envio_error.hide()
	
	timer_cargando = Timer.new()
	add_child(timer_cargando)
	timer_cargando.wait_time = 0.5
	timer_cargando.timeout.connect(_actualizar_puntos)
	timer_cargando.start()

func _actualizar_puntos():
	puntos = (puntos + 1) % 4
	label_puntos.text = ".".repeat(puntos)

func _detener_animacion_cargando():
	if timer_cargando:
		timer_cargando.stop()
		timer_cargando.queue_free()  # limpia el nodo, no solo lo pausa
		timer_cargando = null
	ventana_popup_cargando.hide()



func _on_request_completed(result, response_code, headers, body):
	print("codigo:", response_code)
	var respuesta = body.get_string_from_utf8()
	print("Respuesta del servidor:", respuesta)
	
	_detener_animacion_cargando()
	if response_code == 200:
		ventana_popup_envio_exito.show()
	else:
		ventana_popup_envio_error.show()

	if popup_notificacion_correo:
		popup_notificacion_correo.show()
	if subviewport_container:
		subviewport_container.mouse_filter = Control.MOUSE_FILTER_STOP
