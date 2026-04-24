extends Button

@export var icon_izq: TextureRect
@export var icon_der: TextureRect
@export var http_request: HTTPRequest


func _ready():
	mouse_entered.connect(_mostrar_iconos)
	mouse_exited.connect(_ocultar_iconos)
	
	pressed.connect(_on_boton_generar_reporte_pressed)
	
	_ocultar_iconos()
	
	http_request.request_completed.connect(_on_request_completed)

func _on_boton_generar_reporte_pressed():

	var correo = ControladorPartidaGlobal.partida.jugador["correo_electronico"]
	var analisis = ControladorPartidaGlobal.partida.jugador["analisis"]

	var datos = {
		"email": correo,
		"analisis": analisis
	}

	var json = JSON.stringify(datos)

	var headers = ["Content-Type: application/json"]

	http_request.request(
		"http://127.0.0.1:7000/generar-reporte/",
		headers,
		HTTPClient.METHOD_POST,
		json
	)


func _on_request_completed(result, response_code, headers, body):

	print("codigo:", response_code)

	var respuesta = body.get_string_from_utf8()

	print("Respuesta del servidor:", respuesta)


func _mostrar_iconos():
	icon_izq.visible = true
	icon_der.visible = true

func _ocultar_iconos():
	icon_izq.visible = false
	icon_der.visible = false
