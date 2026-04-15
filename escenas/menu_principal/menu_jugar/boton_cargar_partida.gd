extends Button

@export var icon_izq: TextureRect
@export var icon_der: TextureRect

func _ready():
	mouse_entered.connect(_mostrar_iconos)
	mouse_exited.connect(_ocultar_iconos)
	
	pressed.connect(_jugar)
	
	_ocultar_iconos()

func _jugar():
	var correo_electronico =  ControladorPartidaGlobal.partida.jugador["correo_electronico"]
	ControladorPartidaGlobal.cargar_partida()

	print(correo_electronico)

func _mostrar_iconos():
	icon_izq.visible = true
	icon_der.visible = true

func _ocultar_iconos():
	icon_izq.visible = false
	icon_der.visible = false
