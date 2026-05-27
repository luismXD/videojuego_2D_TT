extends Button


@export var popup_notificacion_correo: CanvasLayer

@export var ventana_popup_envio_exito: PanelContainer

@export var boton_aceptar_correo: Button

@export var subviewport_container: SubViewportContainer


@export var http_request: HTTPRequest


func _ready():
	
	if popup_notificacion_correo:
		popup_notificacion_correo.hide()
	
	if subviewport_container:
		subviewport_container.mouse_filter = Control.MOUSE_FILTER_IGNORE

	
	pressed.connect(_on_boton_generar_reporte_pressed)
	
	
	http_request.request_completed.connect(_on_request_completed)

	if boton_aceptar_correo:
		boton_aceptar_correo.pressed.connect(_on_boton_aceptar_nombre_y_correo)



#func _on_boton_generar_reporte_pressed():
	#if popup_notificacion_correo:
		#popup_notificacion_correo.show()
	#if subviewport_container:
		#subviewport_container.mouse_filter = Control.MOUSE_FILTER_STOP
#
	#var correo = ControladorPartidaGlobal.partida.jugador["correo_electronico"]
	#var analisis = ControladorPartidaGlobal.partida.jugador["analisis"]
#
	#var datos = {
		#"email": correo,
		#"analisis": analisis
	#}
#
	#var json = JSON.stringify(datos)
#
	#var headers = ["Content-Type: application/json"]
#
	#http_request.request(
		#"http://127.0.0.1:8002/generar-reporte/",
		#headers,
		#HTTPClient.METHOD_POST,
		#json
	#)
func _on_boton_generar_reporte_pressed():
	if subviewport_container:
		subviewport_container.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var correo = ControladorPartidaGlobal.partida.jugador["correo_electronico"]
	var analisis = ControladorPartidaGlobal.partida.jugador["analisis"]
	var datos = {
		"email": correo,
		"analisis": analisis
	}
	var json = JSON.stringify(datos)
	var headers = ["Content-Type: application/json"]
	http_request.request(
		"http://127.0.0.1:8002/generar-reporte/",
		headers,
		HTTPClient.METHOD_POST,
		json
	)


func _on_boton_aceptar_nombre_y_correo():
	popup_notificacion_correo.hide()
	if subviewport_container:
		subviewport_container.mouse_filter = Control.MOUSE_FILTER_IGNORE


#func _on_request_completed(result, response_code, headers, body):
#
	#print("codigo:", response_code)
#
	#var respuesta = body.get_string_from_utf8()
#
	#print("Respuesta del servidor:", respuesta)

func _on_request_completed(result, response_code, headers, body):
	print("codigo:", response_code)
	var respuesta = body.get_string_from_utf8()
	print("Respuesta del servidor:", respuesta)

	if response_code == 200:
		if popup_notificacion_correo:
			popup_notificacion_correo.show()
		if subviewport_container:
			subviewport_container.mouse_filter = Control.MOUSE_FILTER_STOP
