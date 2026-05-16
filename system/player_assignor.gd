extends Node
const COLLISION_MASK_PLAYER = 5
func _ready() -> void:
	var player:CharacterBody2D = get_parent()
	player.add_to_group("player")
	var human_controller = HumanController.new()
	player.call_deferred("add_child",human_controller)
	player.set_collision_layer_value(COLLISION_MASK_PLAYER,true)
	
	# Assign player to camera
	for camera in get_tree().get_nodes_in_group("camera"):
		camera.target = player
		# Teleportar cámara inmediatamente si hay posición guardada
		var pos_guardada = ControladorPartidaGlobal.partida.jugador["posicion"]
		if pos_guardada != Vector2.ZERO:
			camera.teleport_to(player.global_position)
	
	queue_free()
