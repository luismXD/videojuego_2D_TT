extends OptionButton

@export var icon_izq: TextureRect
@export var icon_der: TextureRect


func _ready():
	mouse_entered.connect(_mostrar_iconos)
	mouse_exited.connect(_ocultar_iconos)
	item_selected.connect(_configuracion_ventana)

	_ocultar_iconos()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _configuracion_ventana(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)



func _mostrar_iconos():
	icon_izq.visible = true
	icon_der.visible = true

func _ocultar_iconos():
	icon_izq.visible = false
	icon_der.visible = false
