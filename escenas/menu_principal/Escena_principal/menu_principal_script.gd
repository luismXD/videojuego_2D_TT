extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not ControladorPartidaGlobal.partida.jugador.has("ventana"):
		ControladorPartidaGlobal.partida.jugador["ventana"] = 0
	
	_configuracion_ventana(ControladorPartidaGlobal.partida.jugador["ventana"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _configuracion_ventana(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
