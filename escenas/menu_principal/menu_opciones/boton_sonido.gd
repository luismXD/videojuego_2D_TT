extends Button

@export var icon_izq: TextureRect
@export var icon_der: TextureRect
@export var http_request: HTTPRequest


func _ready():
	
	pressed.connect(_on_boton_generar_reporte_pressed)
	
	
	http_request.request_completed.connect(_on_request_completed)

func _on_boton_generar_reporte_pressed():
	print("=== BOTON PRESIONADO ===")
	var correo = ControladorPartidaGlobal.partida.jugador["correo_electronico"]
	var analisis = ControladorPartidaGlobal.partida.jugador["analisis"]

	var datos = {
		"email": correo,
		"analisis": analisis
	}

	var json = JSON.stringify(datos)
	
	print("JSON enviado: ", json)

	var headers = ["Content-Type: application/json"]
	print("Correo:", ControladorPartidaGlobal.partida.jugador["correo_electronico"])
	print("Analisis:", ControladorPartidaGlobal.partida.jugador["analisis"])
	http_request.request(
	"https://merry-adaptation-production-274e.up.railway.app/generar-reporte/",
	headers,
	HTTPClient.METHOD_POST,
	json
)

func _holapapu():
	print("hola papu");

func _on_request_completed(result, response_code, headers, body):
	print("codigo:", response_code)
	var respuesta = body.get_string_from_utf8()
	print("Respuesta del servidor:", respuesta)
	
	if response_code == 200:
		print("[Reporte] Enviado al correo")
		# Opcional: limpiar analisis después de enviar para no duplicar en siguiente reporte
		# ControladorPartidaGlobal.partida.jugador["analisis"] = []
		# ControladorPartidaGlobal.guardar_partida()
	else:
		push_warning("[Reporte] Falló con código %d" % response_code)
