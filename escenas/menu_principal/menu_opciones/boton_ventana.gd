extends OptionButton



func _ready():
	select(ControladorPartidaGlobal.partida.jugador["ventana"])
	item_selected.connect(_configuracion_ventana)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _configuracion_ventana(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	ControladorPartidaGlobal.partida.jugador["ventana"] = index
	ControladorPartidaGlobal.guardar_partida()
