extends Area2D
 
## Prompt de interacción que aparece cuando el jugador se acerca al NPC.
## La escena ya trae las animaciones "show" / "hide" / "default" en el AnimationPlayer.
 
# Se emite cuando el jugador está en rango y presiona el botón de interactuar.
# Conéctala desde el NPC para abrir el diálogo real.
signal interaction_requested
 
@onready var animation_player: AnimationPlayer = $AnimationPlayer
 
# Acción del Input Map que usas para interactuar (créala en Project Settings > Input Map).
@export var interact_action: StringName = &"interact"
 
var _player_in_range: bool = false
 
 
func _ready() -> void:
	# Arranca oculto.
	animation_player.play("default")
 
	# Detectamos al jugador sea body o area; el check de grupo evita doble disparo.
	body_entered.connect(_on_entered)
	body_exited.connect(_on_exited)
	area_entered.connect(_on_entered)
	area_exited.connect(_on_exited)
 
 
func _unhandled_input(event: InputEvent) -> void:
	if _player_in_range and event.is_action_pressed(interact_action):
		interaction_requested.emit()
		get_viewport().set_input_as_handled()
 
 
func _on_entered(node: Node) -> void:
	if not node.is_in_group("player"):
		return
	if _player_in_range:
		return
	_player_in_range = true
	animation_player.play("show")
 
 
func _on_exited(node: Node) -> void:
	if not node.is_in_group("player"):
		return
	if not _player_in_range:
		return
	_player_in_range = false
	animation_player.play("hide")
