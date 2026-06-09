@tool
@icon("res://content/dialog_system/icons/star_bubble.svg")
class_name DialogSystemNode extends CanvasLayer

signal dialog_finished(emotions_log: Array)

# --- Config ---
@export var backend_url: String = "https://adorable-peace-production-a183.up.railway.app"
@export var emotions_url: String = "https://ttbackend-production-10b3.up.railway.app"
#@export var emotions_url: String = "http://127.0.0.1:8001"
# --- Estado ---
var is_active: bool = false
var is_typing: bool = false
var session_id: String = ""
var current_npc_id: String = ""
var can_extend: bool = true
var accumulated_emotions: Array = []
var pending_player_msg: String = ""  # mensaje en espera de emoción
var _closing_forced: bool = false

# --- Nodos UI ---
@onready var dialog_ui: Control = $DialogUI
@onready var rich_text: RichTextLabel = $DialogUI/PanelContainer/RichTextLabel
@onready var name_label: Label = $DialogUI/NameLabel
@onready var portrait_sprite: Sprite2D = $DialogUI/PanelPortrait/PortraitSprite
@onready var timer: Timer = $DialogUI/Timer
@onready var audio: AudioStreamPlayer = $DialogUI/AudioStreamPlayer
@onready var progress_indicator: PanelContainer = $DialogUI/DialogProgressIndicator

# Nuevos
@onready var player_input: LineEdit = $DialogUI/InputContainer/PlayerInput
@onready var send_button: Button = $DialogUI/InputContainer/SendButton
@onready var input_container: HBoxContainer = $DialogUI/InputContainer
@onready var farewell_container: HBoxContainer = $DialogUI/FarewellContainer
@onready var keep_talking_button: Button = $DialogUI/FarewellContainer/KeepTalkingButton
@onready var farewell_button: Button = $DialogUI/FarewellContainer/FarewellButton

#dejense de cosas alv
@export var boton_salir_x: Button


# HTTPRequest (lo creamos por código para no ensuciar la escena)
var http: HTTPRequest


func _ready() -> void:

	if Engine.is_editor_hint():
		if get_viewport() is Window:
			get_parent().remove_child(self)
		return
	
	http = HTTPRequest.new()
	http.process_mode = Node.PROCESS_MODE_ALWAYS  # ← Esta línea es la clave
	add_child(http)
	
	hide_dialog()
	timer.timeout.connect(_on_typewriter_tick)
	send_button.pressed.connect(_on_send_pressed)
	player_input.text_submitted.connect(func(_t): _on_send_pressed())
	keep_talking_button.pressed.connect(_on_keep_talking_pressed)
	farewell_button.pressed.connect(_on_farewell_pressed)

	GameManager.ocultar_dialogo_signal.connect(hide_dialog)
	if boton_salir_x:
		boton_salir_x.pressed.connect(_on_boton_x_pressed)

func _on_boton_x_pressed() -> void:
	if session_id != "":
		_request_end()  # deja que _on_end_response maneje el cierre
	else:
		hide_dialog()   # no hay sesión, cierra directo

# =========================================================
# API PÚBLICA — esto es lo que los NPC llaman
# =========================================================

func start_conversation(npc_id: String, npc_name: String, portrait: Texture2D) -> void:
	if is_active:
		return
	current_npc_id = npc_id
	name_label.text = npc_name
	if portrait:
		portrait_sprite.texture = portrait
	
	_show_dialog()
	_set_input_state(false)  # Bloquea input mientras llega el saludo
	_request_start(npc_id)


# =========================================================
# Backend
# =========================================================

func _request_start(npc_id: String) -> void:
	var url := "%s/conversation/start" % backend_url
	var headers := ["Content-Type: application/json"]
	
	# Leer memoria local del NPC
	var memory = _load_npc_memory(npc_id)
	
	var body := JSON.stringify({
		"npc_id": npc_id,
		"player_id": ControladorPartidaGlobal.partida.jugador["nombre"],
		"npc_memory": memory  # null si es primera vez
	})
	http.request_completed.connect(_on_start_response, CONNECT_ONE_SHOT)
	http.request(url, headers, HTTPClient.METHOD_POST, body)

func _on_start_response(_result, code, _headers, body) -> void:
	if code != 200:
		_display_message("[i](error de conexión)[/i]")
		_set_input_state(true)
		return
	var data: Dictionary = JSON.parse_string(body.get_string_from_utf8())
	session_id = data.get("session_id", "")
	_display_message(data.get("greeting", ""))   # ← era "greeting_message"
	_set_input_state(true)


func _request_chat(message: String, emotion: Dictionary) -> void:
	var url := "%s/conversation/chat" % backend_url
	var headers := ["Content-Type: application/json"]
	var body := JSON.stringify({
		"session_id": session_id,
		"player_message": message,
		"emotion": emotion  # ← NUEVO: ahora Godot le pasa la emoción al backend
	})
	http.request_completed.connect(_on_chat_response, CONNECT_ONE_SHOT)
	http.request(url, headers, HTTPClient.METHOD_POST, body)

func _on_chat_response(_result, code, _headers, body) -> void:
	if code != 200:
		_display_message("[i](el NPC no respondió)[/i]")
		_set_input_state(true)
		return
	var data: Dictionary = JSON.parse_string(body.get_string_from_utf8())
	var npc_message: String = data.get("npc_message", "")
	_display_message(npc_message)
	
	# completar el último análisis guardado con la respuesta del NPC
	var analisis: Array = ControladorPartidaGlobal.partida.jugador["analisis"]
	if analisis.size() > 0:
		analisis[analisis.size() - 1]["npc_response"] = npc_message
		ControladorPartidaGlobal.guardar_partida()
	
	if data.get("should_end", false):
		await get_tree().create_timer(2.0).timeout
		_request_end()
		return
	
	if data.get("offer_farewell", false):
		can_extend = data.get("can_extend", false)
		_show_farewell_options()
	else:
		_set_input_state(true)

func _request_end() -> void:
	_display_message("[i]...[/i]")  # ← feedback visual inmediato
	if boton_salir_x:
		boton_salir_x.disabled = true
	var url := "%s/conversation/end" % backend_url
	var headers := ["Content-Type: application/json"]
	var body := JSON.stringify({"session_id": session_id})
	http.request_completed.connect(_on_end_response, CONNECT_ONE_SHOT)
	http.request(url, headers, HTTPClient.METHOD_POST, body)
#func _request_end() -> void:
	#var url := "%s/conversation/end" % backend_url
	#var headers := ["Content-Type: application/json"]
	#var body := JSON.stringify({"session_id": session_id})
	#http.request_completed.connect(_on_end_response, CONNECT_ONE_SHOT)
	#http.request(url, headers, HTTPClient.METHOD_POST, body)

#func _on_end_response(_result, code, _headers, body) -> void:
	## Aunque el backend falle, el diálogo DEBE cerrarse del lado del jugador,
	## si no, se queda atorado para siempre.
	#
	#if code == 200:
		#var data = JSON.parse_string(body.get_string_from_utf8())
		#if data is Dictionary:
			#var emotions_log: Array = data.get("emotions_log", [])
			#accumulated_emotions.append({
				#"npc_id": current_npc_id,
				#"log": emotions_log
			#})
			#var farewell: String = data.get("farewell", "")
			#if farewell != "":
				#_display_message(farewell)
				#await get_tree().create_timer(3.0).timeout
	#else:
		## Error del backend (500, 502, etc.). Avisamos y cerramos igual.
		#push_warning("[DialogSystem] /conversation/end falló con código %d. Cerrando diálogo." % code)
		#_display_message("[i](la conversación terminó)[/i]")
		#await get_tree().create_timer(1.5).timeout
	#
	#hide_dialog()
func _on_end_response(_result, code, _headers, body) -> void:
	if code == 200:
		var data = JSON.parse_string(body.get_string_from_utf8())
		if data is Dictionary:
			_save_npc_memory(current_npc_id, data.get("npc_memory", {}))
			var emotions_log: Array = data.get("emotions_log", [])
			accumulated_emotions.append({
				"npc_id": current_npc_id,
				"log": emotions_log
			})
			var farewell: String = data.get("farewell", "")
			if farewell != "":
				if boton_salir_x:
					boton_salir_x.disabled = false  # ← siempre habilitado
				_display_message(farewell)
				while is_typing:
					await get_tree().process_frame
				if boton_salir_x:
					await boton_salir_x.pressed  # ← espera el PRÓXIMO press
	else:
		push_warning("[DialogSystem] /conversation/end falló con código %d." % code)
		_display_message("[i](la conversación terminó)[/i]")
		if boton_salir_x:
			boton_salir_x.disabled = false
			await boton_salir_x.pressed
	
	hide_dialog()

func _load_npc_memory(npc_id: String) -> Variant:
	var path := "user://memoria/%s.json" % npc_id
	if not FileAccess.file_exists(path):
		return null
	var f := FileAccess.open(path, FileAccess.READ)
	return JSON.parse_string(f.get_as_text())

func _save_npc_memory(npc_id: String, memory: Dictionary) -> void:
	if npc_id.is_empty():  # ← guard
		push_warning("[DialogSystem] npc_id vacío, no se guarda memoria.")
		return
	DirAccess.make_dir_recursive_absolute("user://memoria")
	var path := "user://memoria/%s.json" % npc_id
	var f := FileAccess.open(path, FileAccess.WRITE)
	f.store_string(JSON.stringify(memory))
	
# =========================================================
# Flujo UI
# =========================================================

func _on_send_pressed() -> void:
	var msg := player_input.text.strip_edges()

	# Guardar el mensaje directamente como string
	#ControladorPartidaGlobal.partida.jugador["analisis"].append(msg)
	#ControladorPartidaGlobal.guardar_partida()
	#
	## No necesitas cargar_partida() inmediatamente después de guardar
	#print(ControladorPartidaGlobal.partida.jugador["analisis"])
	#

	if msg.is_empty() or is_typing:
		return
	player_input.text = ""
	_set_input_state(false)
	rich_text.text = "[color=#7a7a7a][i]Tú: %s[/i][/color]" % msg
	
	pending_player_msg = msg
	_request_emotion(msg)

func _request_emotion(text: String) -> void:
	var url := "%s/analizar/%s" % [emotions_url, text.uri_encode()]
	http.request_completed.connect(_on_emotion_response, CONNECT_ONE_SHOT)
	http.request(url)

func _on_emotion_response(_result, code, _headers, body) -> void:
	var emotion_data: Dictionary = {}
	
	if code == 200:
		var parsed = JSON.parse_string(body.get_string_from_utf8())
		if parsed is Dictionary:
			emotion_data = parsed
			# Guardar en la partida (formato compatible con report_service)
			ControladorPartidaGlobal.partida.jugador["analisis"].append(emotion_data)
			ControladorPartidaGlobal.guardar_partida()
			print("[DialogSystem] Emoción guardada: %s (%.2f)" % [
				emotion_data.get("emocion_predicha", "?"),
				emotion_data.get("confianza", 0.0)
			])
	else:
		push_warning("[DialogSystem] /analizar falló con código %d. Continuando sin emoción." % code)
		emotion_data = {
			"texto_analizado": pending_player_msg,
			"emocion_predicha": "desconocido",
			"probabilidades": {},
			"confianza": 0.0
		}
	
	# Ahora llamamos al conversation_service con la emoción ya detectada
	_request_chat(pending_player_msg, emotion_data)

func _on_keep_talking_pressed() -> void:
	farewell_container.visible = false
	if can_extend:
		_request_extend()
	else:
		_request_end()

func _request_extend() -> void:
	var url := "%s/conversation/extend" % backend_url
	var headers := ["Content-Type: application/json"]
	var body := JSON.stringify({"session_id": session_id})
	http.request_completed.connect(_on_extend_response, CONNECT_ONE_SHOT)
	http.request(url, headers, HTTPClient.METHOD_POST, body)

func _on_extend_response(_result, code, _headers, _body) -> void:
	if code != 200:
		_display_message("[i](no se pudo extender)[/i]")
	_set_input_state(true)

func _on_farewell_pressed() -> void:
	farewell_container.visible = false
	_request_end()

func _show_farewell_options() -> void:
	input_container.visible = false
	farewell_container.visible = true
	keep_talking_button.disabled = not can_extend
	keep_talking_button.text = "Seguir platicando" if can_extend else "(no se puede extender)"


# =========================================================
# Mostrar texto del NPC (typewriter)
# =========================================================

func _display_message(text: String) -> void:
	rich_text.text = text
	rich_text.visible_characters = 0
	is_typing = true
	progress_indicator.visible = false
	timer.wait_time = 0.03
	timer.start()

func _on_typewriter_tick() -> void:
	rich_text.visible_characters += 1
	if rich_text.visible_characters >= rich_text.get_total_character_count():
		_finish_typing()

func _finish_typing() -> void:
	timer.stop()
	is_typing = false
	rich_text.visible_characters = -1


# =========================================================
# Mostrar / ocultar
# =========================================================

func _show_dialog() -> void:
	is_active = true
	dialog_ui.visible = true
	dialog_ui.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true

func hide_dialog() -> void:
	is_active = false
	dialog_ui.visible = false
	dialog_ui.process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = false
	session_id = ""
	current_npc_id = ""
	farewell_container.visible = false
	input_container.visible = true
	dialog_finished.emit(accumulated_emotions)

func _set_input_state(enabled: bool) -> void:
	input_container.visible = true
	farewell_container.visible = false
	player_input.editable = enabled
	send_button.disabled = not enabled
	if enabled:
		player_input.grab_focus()


# =========================================================
# Al cerrar el juego — para mandar al servicio de reportes
# =========================================================

func get_all_emotions() -> Array:
	return accumulated_emotions
