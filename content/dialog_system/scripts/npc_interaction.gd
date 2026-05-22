class_name NPCInteraction extends Area2D

@export var npc_id: String = "samurai_blue"        # debe matchear con tus npc_configs/*.json
@export var npc_name: String = "Samurai Blue"
@export var portrait: Texture2D

var player_in_range: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	print("[NPC %s] body_entered: %s | groups: %s" % [npc_id, body.name, body.get_groups()])
	if body.is_in_group("player"):
		player_in_range = true
		print("[NPC %s] ✓ jugador en rango" % npc_id)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		print("[NPC %s] ✗ jugador salió" % npc_id)

func _unhandled_input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("interact"):
		print("[NPC %s] interact presionado, is_active=%s" % [npc_id, DialogSystem.is_active])
		if not DialogSystem.is_active:
			DialogSystem.start_conversation(npc_id, npc_name, portrait)
