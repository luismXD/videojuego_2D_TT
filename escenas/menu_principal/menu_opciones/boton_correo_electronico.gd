extends Button

#var texto_codificado = texto.uri_encode()
#var url = "http://localhost:8000/analizar/" + texto_codificado
#http_request.request(url)

@export var popup_layer: CanvasLayer
@export var ventana_popup: PanelContainer
@export var texto_input: LineEdit
@export var http_request: HTTPRequest

#@export var boton_nueva_partida: Button  # Nuevo export
@export var boton_enviar: Button      
@export var boton_regresar:Button


@export var icon_izq: TextureRect
@export var icon_der: TextureRect


func _ready():
	mouse_entered.connect(_mostrar_iconos)
	mouse_exited.connect(_ocultar_iconos)
	
	pressed.connect(_on_boton_reporte_emocional_pressed)
	
	_ocultar_iconos()

	if popup_layer:
		popup_layer.hide()
	if boton_enviar:
		boton_enviar.pressed.connect(_on_boton_comenzar_pressed)
	if boton_regresar:
		boton_regresar.pressed.connect(_on_boton_regresar_pressed)
		
	http_request.request_completed.connect(_on_request_completed)

func _on_boton_reporte_emocional_pressed():
	if popup_layer:
		popup_layer.show()
		print("Popup mostrado")

func _on_boton_comenzar_pressed():
	var texto = texto_input.text
	var texto_codificado = texto.uri_encode()

	if texto != "":
		print("Textoe enviado ", texto)
		var url = "http://127.0.0.1:8000/analizar/" + texto_codificado
		http_request.request(url)
	else:
		print("Por favor complete el campo")

func _on_boton_regresar_pressed():
	popup_layer.hide()

func _on_request_completed(result, response_code, headers, body):
	print("codigo:", response_code)
	print("result:", result)

	var respuesta = body.get_string_from_utf8()
	print("Respuesta del microservicio:", respuesta)

#var respuesta = body.get_string_from_utf8()

	var json_data = JSON.parse_string(respuesta)

	ControladorPartidaGlobal.partida.jugador["analisis"].append(json_data)
	#ControladorPartidaGlobal.cargar_partida()
	#ControladorPartidaGlobal.partida.jugador["analisis"].append(respuesta)
	ControladorPartidaGlobal.guardar_partida()


	print("ingatumadre se guardo?: ", ControladorPartidaGlobal.partida.jugador["analisis"])
	popup_layer.hide()


#func _cambiar_escena(escena: bool):
	##controlador_partida.borrar_partida()
	#if escena == true:
		#get_tree().change_scene_to_file("res://escenas/mundo_abierto/escenario_principal/escenario_principal.tscn")



func _mostrar_iconos():
	icon_izq.visible = true
	icon_der.visible = true

func _ocultar_iconos():
	icon_izq.visible = false
	icon_der.visible = false
