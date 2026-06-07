#class_name NPCInteraction extends Area2D
#
##@export var ventana_popup: PanelContainer
#@export var npc_id: String = "aldeana_mascara_azul"        # debe matchear con tus npc_configs/*.json
#@export var npc_name: String = "Aldeana de Máscara Azul"
#@export var portrait: Texture2D
##Hina, la Aprendiz
#
#
#var player_in_range: bool = false
#
#func _ready() -> void:
#
	#body_entered.connect(_on_body_entered)
	#body_exited.connect(_on_body_exited)
#
#func _on_body_entered(body: Node2D) -> void:
	#print("[NPC %s] body_entered: %s | groups: %s" % [npc_id, body.name, body.get_groups()])
	#if body.is_in_group("player"):
		#player_in_range = true
		#print("[NPC %s] ✓ jugador en rango" % npc_id)
		##mostrar_canvas_layer.show()
		#GameManager.jugador_interaction_en_rango()
#
#
#
#func _on_body_exited(body: Node2D) -> void:
	#if body.is_in_group("player"):
		#player_in_range = false
		#print("[NPC %s] ✗ jugador salió" % npc_id)
		##mostrar_canvas_layer.hide()
		#GameManager.jugador_interaction_fuera_rango()
#
#
#func _unhandled_input(event: InputEvent) -> void:
	#if player_in_range and event.is_action_pressed("interact"):
		#print("[NPC %s] interact presionado, is_active=%s" % [npc_id, DialogSystem.is_active])
		#if not DialogSystem.is_active:
			#DialogSystem.start_conversation(npc_id, npc_name, portrait)





















#class_name NPCInteraction extends Area2D
#
#@export var npc_id: String = "aldeana_mascara_azul"
#@export var npc_name: String = "Aldeana de Máscara Azul"
#@export var portrait: Texture2D
#@export var indicador: Sprite2D # hijo directo de este NPC
#
#@export var es_cartel: bool = false
#@export var canvas_layer_cartel: CanvasLayer
#
#var player_in_range: bool = false
#
#func _ready() -> void:
	#indicador.hide()
	#if canvas_layer_cartel:
		#canvas_layer_cartel.visible = false  # arranca oculto
	#body_entered.connect(_on_body_entered)
	#body_exited.connect(_on_body_exited)
#
#
#func _on_body_entered(body: Node2D) -> void:
	#if body.is_in_group("player"):
		#player_in_range = true
		#indicador.show()  # solo muestra el de ESTE npc
		#GameManager.jugador_interaction_en_rango()
#
##func _on_body_exited(body: Node2D) -> void:
	##if body.is_in_group("player"):
		##player_in_range = false
		##indicador.hide()  # solo oculta el de ESTE npc
		##GameManager.jugador_interaction_fuera_rango()
#func _on_body_exited(body: Node2D) -> void:
	#if body.is_in_group("player"):
		#player_in_range = false
		#indicador.hide()
		#if es_cartel and canvas_layer_cartel:
			#canvas_layer_cartel.visible = false  # si te alejas, se cierra
		#GameManager.jugador_interaction_fuera_rango()
#
#func _unhandled_input(event: InputEvent) -> void:
	#if player_in_range and event.is_action_pressed("interact"):
		#if not DialogSystem.is_active:
			#DialogSystem.start_conversation(npc_id, npc_name, portrait)



















#class_name NPCInteraction extends Area2D
#
#@export var npc_id: String = "aldeana_mascara_azul"
#@export var npc_name: String = "Aldeana de Máscara Azul"
#@export var portrait: Texture2D
#@export var indicador: Sprite2D # hijo directo de este NPC
#
#@export var es_cartel: bool = false
#
#@export var canvas_layer_cartel: CanvasLayer
#@export var boton_aceptar_cartel: Button
#@export var boton_aceptar_final: Button
#var player_in_range: bool = false
## Pa las misiones
#@export var quest: Quest
#var moneda:= load("res://system/ui/simple_quest_system/moneda.tscn")
#@export var positionMoneda: Marker2D
#
#func _ready() -> void:
	#indicador.hide()
#
		#
	#if es_cartel:
		## este nodo debe seguir recibiendo input aunque el árbol esté pausado
		#process_mode = Node.PROCESS_MODE_ALWAYS
		#if canvas_layer_cartel:
			#canvas_layer_cartel.visible = false  # arranca oculto
			## la UI también debe vivir durante la pausa (el botón y sus hijos
			## heredan este modo automáticamente)
			#canvas_layer_cartel.process_mode = Node.PROCESS_MODE_ALWAYS
		#if boton_aceptar_cartel:
			#boton_aceptar_cartel.pressed.connect(_on_boton_aceptar_pressed)
		#if boton_aceptar_final:
			#boton_aceptar_final.pressed.connect(_on_boton_aceptar_final)
	#body_entered.connect(_on_body_entered)
	#body_exited.connect(_on_body_exited)
#
#func _on_boton_aceptar_final() -> void:
	#if canvas_layer_cartel:
		#canvas_layer_cartel.visible = false
	#get_tree().paused = false  # reanuda
	#GameManager.guardar_posicion()
##
	#get_tree().change_scene_to_file("res://escenas/menu_principal/menu_jugar/escena_menu_jugar.tscn")
#
#func _on_body_entered(body: Node2D) -> void:
	#if body.is_in_group("player"):
		#player_in_range = true
		#indicador.show()
		#GameManager.jugador_interaction_en_rango()
	#
#
#func _on_body_exited(body: Node2D) -> void:
	#if body.is_in_group("player"):
		#player_in_range = false
		#indicador.hide()
		#GameManager.jugador_interaction_fuera_rango()
#
#func _unhandled_input(event: InputEvent) -> void:
	#if player_in_range and event.is_action_pressed("interact"):
		#if es_cartel:
			#_abrir_cartel()
		#elif not DialogSystem.is_active:
			#DialogSystem.start_conversation(npc_id, npc_name, portrait)
#
#func _abrir_cartel() -> void:
	#if canvas_layer_cartel:
		#canvas_layer_cartel.visible = true
		#get_tree().paused = true  # congela al jugador (y todo lo demás)
#
#func _on_boton_aceptar_pressed() -> void:
	#if canvas_layer_cartel:
		#canvas_layer_cartel.visible = false
	#get_tree().paused = false  # reanuda











class_name NPCInteraction extends Area2D

@export var npc_id: String = "aldeana_mascara_azul"
@export var npc_name: String = "Aldeana de Máscara Azul"
@export var portrait: Texture2D
@export var indicador: Sprite2D
@export var es_cartel: bool = false
@export var es_area_final: bool = false  # <-- nuevo
@export var canvas_layer_cartel: CanvasLayer
@export var boton_aceptar_cartel: Button
@export var boton_aceptar_final: Button

var player_in_range: bool = false

#@export var quest: Quest
var moneda := load("res://system/ui/simple_quest_system/moneda.tscn")
#@export var positionMoneda: Marker2D

func _ready() -> void:
	indicador.hide()

	if es_cartel or es_area_final:
		process_mode = Node.PROCESS_MODE_ALWAYS
		if canvas_layer_cartel:
			canvas_layer_cartel.visible = false
			canvas_layer_cartel.process_mode = Node.PROCESS_MODE_ALWAYS
		if boton_aceptar_cartel:
			boton_aceptar_cartel.pressed.connect(_on_boton_aceptar_pressed)
		if boton_aceptar_final:
			boton_aceptar_final.pressed.connect(_on_boton_aceptar_final)

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		GameManager.jugador_interaction_en_rango()

		if es_area_final:
			# muestra el canvas directamente, sin presionar E
			if canvas_layer_cartel:
				canvas_layer_cartel.visible = true
				get_tree().paused = true
		else:
			# comportamiento normal: muestra el sprite indicador
			indicador.show()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		indicador.hide()
		if es_area_final and canvas_layer_cartel:
			canvas_layer_cartel.visible = false
			get_tree().paused = false
		GameManager.jugador_interaction_fuera_rango()

func _unhandled_input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("interact"):
		if es_area_final:
			pass  # ya se abrió solo, el botón lo cierra
		elif es_cartel:
			_abrir_cartel()
		elif not DialogSystem.is_active:
			DialogSystem.start_conversation(npc_id, npc_name, portrait)

func _abrir_cartel() -> void:
	if canvas_layer_cartel:
		canvas_layer_cartel.visible = true
		get_tree().paused = true

func _on_boton_aceptar_pressed() -> void:
	if canvas_layer_cartel:
		canvas_layer_cartel.visible = false
	get_tree().paused = false

#func _on_boton_aceptar_final() -> void:
	#if canvas_layer_cartel:
		#canvas_layer_cartel.visible = false
	#get_tree().paused = false
	#GameManager.guardar_posicion()
	#get_tree().change_scene_to_file("res://escenas/menu_principal/menu_jugar/escena_menu_jugar.tscn")
func _on_boton_aceptar_final() -> void:
	if canvas_layer_cartel:
		canvas_layer_cartel.visible = false
	get_tree().paused = false
	
	# mueve al jugador 20px arriba antes de guardar
	var jugador = get_tree().get_first_node_in_group("player")
	if jugador:
		jugador.global_position.y -= 20
	
	GameManager.guardar_posicion()
	get_tree().change_scene_to_file("res://escenas/menu_principal/menu_jugar/escena_menu_jugar.tscn")
