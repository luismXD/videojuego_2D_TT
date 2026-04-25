extends OptionButton

@export var icon_izq: TextureRect
@export var icon_der: TextureRect


func _ready():
	item_selected.connect(_configuracion_ventana)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _configuracion_ventana(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
