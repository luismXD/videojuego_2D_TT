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

class_name NPCInteraction extends Area2D

@export var npc_id: String = "aldeana_mascara_azul"
@export var npc_name: String = "Aldeana de Máscara Azul"
@export var portrait: Texture2D

@export var indicador: Sprite2D # hijo directo de este NPC

var player_in_range: bool = false

func _ready() -> void:
	indicador.hide()  # solo oculta el de ESTE npc
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		indicador.show()  # solo muestra el de ESTE npc
		GameManager.jugador_interaction_en_rango()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		indicador.hide()  # solo oculta el de ESTE npc
		GameManager.jugador_interaction_fuera_rango()

func _unhandled_input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("interact"):
		if not DialogSystem.is_active:
			DialogSystem.start_conversation(npc_id, npc_name, portrait)
